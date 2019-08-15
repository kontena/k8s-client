RSpec.describe K8s::Transport do
  include FixtureHelpers

  describe '#self.config' do
    context 'for a typical kubeadm admin.conf' do
      let(:server_cert) { OpenSSL::X509::Certificate.new fixture('config/kubeadm-apiserver-cert.pem') }

      subject { described_class.config(K8s::Config.load_file(fixture_path('config/kubeadm-admin.conf')))}

      before do
        allow_any_instance_of(OpenSSL::X509::Store).to receive(:verify).with(server_cert).and_return(true)
      end

      it 'uses the correct server' do
        expect(subject.server).to eq 'https://192.168.56.11:6443'
      end

      it 'uses the correct path' do
        expect(subject.path).to eq '/'
      end

      it 'uses the correct options' do
        expect(subject.options).to match(
          ssl_cert_store: OpenSSL::X509::Store,
          client_cert_data: /^-----BEGIN CERTIFICATE-----\n/,
          client_key_data: /^-----BEGIN RSA PRIVATE KEY-----\n/,
        )
      end

      it 'uses an ssl_cert_store that verifies the server cert' do
        expect(subject.options[:ssl_cert_store]).to be_a OpenSSL::X509::Store
      end

      context "for URIs with a path prefix" do
        subject { described_class.config(K8s::Config.load_file(fixture_path('config/kubeadm-admin-with-path-prefix.conf')))}

        it 'uses the correct server' do
          expect(subject.server).to eq 'https://192.168.56.11:6443'
        end

        it 'uses the correct path' do
          expect(subject.path).to eq '/k8s/clusters/c-dnmgm/'
        end

        it 'uses the correct options' do
          expect(subject.options).to match(
            ssl_cert_store: OpenSSL::X509::Store,
            client_cert_data: /^-----BEGIN CERTIFICATE-----\n/,
            client_key_data: /^-----BEGIN RSA PRIVATE KEY-----\n/,
          )
        end
      end

      context "overriding the server option" do
        subject {
          described_class.config(K8s::Config.load_file(fixture_path('config/kubeadm-admin.conf')),
            server: 'http://localhost:8001',
          )
        }

        it "uses the overriden server" do
          expect(subject.server).to eq 'http://localhost:8001'
        end

        context "for URIs with a path prefix" do
          subject { described_class.config(K8s::Config.load_file(fixture_path('config/kubeadm-admin-with-path-prefix.conf')),
              server: 'http://localhost:8001',
            )
          }

          it 'uses the correct server' do
            expect(subject.server).to eq 'http://localhost:8001'
          end

          it 'uses the correct path' do
            expect(subject.path).to eq '/'
          end
        end
      end

      context "overriding other options" do
        subject {
          described_class.config(K8s::Config.load_file(fixture_path('config/kubeadm-admin.conf')),
            ssl_verify_peer: false,
          )
        }

        it "uses the overriden server" do
          expect(subject.options).to match hash_including(
            ssl_verify_peer: false,
          )
        end
      end
    end

    context 'for a kubeconfig using token auth' do
      let(:config) { K8s::Config.new(
        clusters: [
          {
            name: 'kubernetes',
            cluster: {
              server: 'http://localhost:8080',
              certificate_authority: 'ca.pem',

            }
          }
        ],
        users: [
          {
            name: 'test',
            user: {
              token: 'SECRET',
            }
          }
        ],

        contexts: [
          {
            name: 'test',
            context: {
              cluster: 'kubernetes',
              user: 'test'
            }
          }
        ],
        current_context: 'test'
      ) }

      subject { described_class.config(config) }

      it 'uses the correct server' do
        expect(subject.server).to eq 'http://localhost:8080'
      end

      it 'uses the correct options' do
        expect(subject.options).to match(
          ssl_ca_file: 'ca.pem',
        )
      end

      describe '#request_options' do
        it "includes the Authorization token" do
          expect(subject.request_options(method: 'GET', path: '/')).to eq({
            method: 'GET',
            path: '/',
            headers: {
              'Authorization' => 'Bearer SECRET',
            },
          })
        end
      end
    end

    context 'for a kubeconfig using username and password auth' do
      let(:config) { K8s::Config.new(
        clusters: [
          {
            name: 'kubernetes',
            cluster: {
              server: 'http://localhost:8080',
              certificate_authority: 'ca.pem',

            }
          }
        ],
        users: [
          {
            name: 'test',
            user: {
              username: 'user',
              password: 'SECRET'
            }
          }
        ],

        contexts: [
          {
            name: 'test',
            context: {
              cluster: 'kubernetes',
              user: 'test'
            }
          }
        ],
        current_context: 'test'
      ) }

      subject { described_class.config(config) }

      describe '#request_options' do
        it "includes the Authorization token" do
          expect(subject.request_options(method: 'GET', path: '/')).to eq({
            method: 'GET',
            path: '/',
            headers: {
              'Authorization' => "Basic #{Base64.strict_encode64('user:SECRET')}",
            },
          })
        end
      end
    end

    context 'for a kubeconfig using auth-provider' do
      let(:config) { K8s::Config.new(
        clusters: [
          {
            name: 'kubernetes',
            cluster: {
              server: 'http://localhost:8080',
              certificate_authority: 'ca.pem',

            }
          }
        ],
        users: [
          {
            name: 'test',
            user: {
              auth_provider: {
                name: 'fake',
                config: {
                  'cmd-path' => 'cat',
                  'cmd-args' => "#{fixture_path}/config/kubeconfig_auth_provider_data.json",
                  'token-key' => '{.credential.access_token}'
                }
              }
            }
          }
        ],

        contexts: [
          {
            name: 'test',
            context: {
              cluster: 'kubernetes',
              user: 'test'
            }
          }
        ],
        current_context: 'test'
      ) }

      subject { described_class.config(config) }

      describe '#request_options' do
        it "includes the Authorization token" do
          expect(subject.request_options(method: 'GET', path: '/')).to eq({
            method: 'GET',
            path: '/',
            headers: {
              'Authorization' => 'Bearer SECRET_TOKEN',
            },
          })
        end
      end
    end
  end

  context 'for a kubeconfig using exec' do
    let(:config) { K8s::Config.new(
      clusters: [
        {
          name: 'kubernetes',
          cluster: {
            server: 'http://localhost:8080',
            certificate_authority: 'ca.pem',

          }
        }
      ],
      users: [
        {
          name: 'test',
          user: {
            exec: {
              apiVersion: 'client.authentication.k8s.io/v1beta1',
              command: 'cat',
              env: [
                { 'name' => 'CUSTOM_ENV', 'value' => '123' }
              ],
              args: [
                "#{fixture_path}/config/kubeconfig_user_exec_data.json"
              ]
            }
          }
        }
      ],

      contexts: [
        {
          name: 'test',
          context: {
            cluster: 'kubernetes',
            user: 'test'
          }
        }
      ],
      current_context: 'test'
    ) }

    subject { described_class.config(config) }

    describe '#request_options' do
      it "includes the Authorization token" do
        expect(subject.request_options(method: 'GET', path: '/')).to eq({
          method: 'GET',
          path: '/',
          headers: {
            'Authorization' => 'Bearer my-bearer-token',
          },
        })
      end
    end
  end

  describe '#self.in_cluster_config' do
    context "with envs set" do
      let(:service_host) { '10.96.0.1' }
      let(:service_port) { '443' }
      let(:sa_token) { 'eyJhbGciOiJSUzI1NiIsImtpZCI6IiJ9.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJkZWZhdWx0Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6ImRlZmF1bHQtdG9rZW4tbmIybDgiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC5uYW1lIjoiZGVmYXVsdCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6Ijg2Y2EwMTZiLTgwMWMtMTFlOC05YWJkLTAyYTNiZTI0YjE0ZiIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDpkZWZhdWx0OmRlZmF1bHQifQ.qJJP3-CswxUeTss7zIV0ghGS0AaE-ZJpq9mT9p_hS6enoCNZaEBPdSqoRH4YIitQhr4_P0eRe_nOrXD0683cq9e31u_FO9qg_4sv1lYwgH52_9EPSZn5NEj2Os1OhlDoxyFzxzCoq-_O289w6HoQYvic77ycy0tKte8sngz4XzWufzyE1m5_qrV6qHJIeh_ygFfmO_yLMDtza5IwupPTgAXfk06h50iydVgmWTNOYfxb9qVP_w8fZanQ59KgM-9e6csWG2k68nMAm4UDETfz-eergviUEUZCtVLNyy5xv3sK-vxtEHX-HnvZVwwZpkf956cbXY6eQLAIUnF5vJt-' }
      let(:sa_cacert) {
        <<-EOF
        -----BEGIN CERTIFICATE-----
          MIICyDCCAbCgAwIBAgIBADANBgkqhkiG9w0BAQsFADAVMRMwEQYDVQQDEwprdWJl
          cm5ldGVzMB4XDTE4MDcwNTA2MjcxNFoXDTI4MDcwMjA2MjcxNFowFTETMBEGA1UE
          AxMKa3ViZXJuZXRlczCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKEx
          4tesvWXTWVxvUPw1pKoM6a74XOFTStaxwF+p1LTCT7rfvQ76w0zk8squdHt1ILFH
          2zbkWvou+pYa5A5aI1R9LfMoHdOCfTypjfgCUTst9ujlngGf+s4TTjFwY30oISQY
          Ghu/j6A/x3mhaCJl836JHFy6CNq59991Nn09CODWsCOmFzDv7+eZHfbW3H255aJE
          nsKdGE2vz3RvuindTRMEfxisTdFlua6B1jw01v1daZW/zNlIqz44bxRNNiN4XKVx
          y2joGXH25innvg8t40/RBI+ojjiqMgAIQPuduRZqmibrLs+CvkFqEUZiwqgVKFFB
          pTt4tpy65HrFFeWppacCAwEAAaMjMCEwDgYDVR0PAQH/BAQDAgKkMA8GA1UdEwEB
          /wQFMAMBAf8wDQYJKoZIhvcNAQELBQADggEBAJla7z1VoGO2cb/M/+DIqmoB+xOe
          cAIMBqa3WeFPQvu7gElhwq0EFwSBdm9JzGLjTtqlfyj//xH0sO0ukwY/MNDa87le
          WOYldSwEnVAxfV4oSE57bxr/MxMXVyXEuCsUNLXWloR3nucxH4t3PTRWFkz4rgVR
          OyYKl/l8UoYAd9W+lDpZkVWkj1l6WA2YrNXAWme3golLKqKIJYMHJRXUnpGIcvHu
          YVChljn5P2znnEkFk9i5mf6td9W4A+sG0MBdWw6mItEdRfc41SPYH+qD0d6Zd3sS
          6g4aip8ggfDoRn0C/AJoyEVLQ/FOw/nkCI6tCH46jfWjM+ojelUCHtLpqcE=
          -----END CERTIFICATE-----
        EOF
      }

      before do
        allow(ENV).to receive(:[]).with('TELEPRESENCE_ROOT').and_return(nil)
        allow(ENV).to receive(:[]).with('KUBERNETES_SERVICE_HOST').and_return(service_host)
        allow(ENV).to receive(:[]).with('KUBERNETES_SERVICE_PORT_HTTPS').and_return(service_port)
        allow(File).to receive(:read).with('/var/run/secrets/kubernetes.io/serviceaccount/token').and_return(sa_token)
        allow(File).to receive(:read).with('/var/run/secrets/kubernetes.io/serviceaccount/ca.crt').and_return(sa_cacert)
      end

      subject { described_class.in_cluster_config }


      it 'uses the correct server' do
        expect(subject.server).to eq 'https://10.96.0.1:443'
      end

      it 'uses the correct options' do
        expect(subject.options).to match(
          ssl_ca_file: '/var/run/secrets/kubernetes.io/serviceaccount/ca.crt',
          ssl_verify_peer: true,
        )
      end

      it 'uses the auth token for request options' do
        expect(subject.request_options[:headers]).to match hash_including(
          'Authorization' => "Bearer #{sa_token}",
        )
      end

      context 'with telepresence' do
        before do
          allow(ENV).to receive(:[]).with('TELEPRESENCE_ROOT').and_return('/tmp')
          allow(File).to receive(:read).with('/tmp/var/run/secrets/kubernetes.io/serviceaccount/token').and_return(sa_token)
          allow(File).to receive(:read).with('/tmp/var/run/secrets/kubernetes.io/serviceaccount/ca.crt').and_return(sa_cacert)
        end

        it 'uses the correct server' do
          subject.server
        end
      end
    end

    context 'without envs set' do
      before do
        allow(ENV).to receive(:[]).with('TELEPRESENCE_ROOT').and_return(nil)
        allow(ENV).to receive(:[]).with('KUBERNETES_SERVICE_HOST').and_return(nil)
        allow(ENV).to receive(:[]).with('KUBERNETES_SERVICE_PORT_HTTPS').and_return(nil)
      end

      it 'fails when KUBERNETES_SERVICE_HOST not defined' do
        expect {
          described_class.in_cluster_config
        }.to raise_error(K8s::Error::Configuration)
      end

      it 'fails when KUBERNETES_SERVICE_HOST not defined' do
        allow(ENV).to receive(:[]).with('KUBERNETES_SERVICE_HOST').and_return('foo')
        expect(ENV).to receive(:[]).with('KUBERNETES_SERVICE_PORT_HTTPS').and_return(nil)
        expect {
          described_class.in_cluster_config
        }.to raise_error(K8s::Error::Configuration)
      end


    end
  end

  let(:server) { 'http://localhost:8080' }
  let(:options) { {} }

  subject { described_class.new(server, **options) }

  describe '#path' do
    it 'returns an empty path starting with /' do
      expect(subject.path).to eq '/'
    end

    it 'returns a path with api' do
      expect(subject.path('api', 'foo')).to eq '/api/foo'
    end

    it 'returns a path with apis' do
      expect(subject.path('apis/test', 'foo')).to eq '/apis/test/foo'
    end
  end

  context "for a stub /test returning JSON" do
    before do
      stub_request(:get, 'localhost:8080/test')
        .to_return(
          status: 200,
          body: JSON.dump({'test' => true}),
          headers: { 'Content-Type' => 'application/json' }
        )
    end

    describe '#get' do
      it "returns the test JSON" do
        expect(subject.get('/test')).to eq({'test' => true})
      end
    end

    context '#get with path prefix' do
      before do
        stub_request(:get, 'localhost:8080/path/prefix/test')
          .to_return(
            status: 200,
            body: JSON.dump({'test' => true}),
            headers: { 'Content-Type' => 'application/json' }
          )
      end

      let(:server) { 'http://localhost:8080/path/prefix' }

      it "returns the test JSON" do
        expect(subject.get('/test')).to eq({'test' => true})
      end
    end
  end

  context "for a stub /test returning non-status 404" do
    before do
      stub_request(:get, 'localhost:8080/test')
        .to_return(
          status: [404, "Not Found"],
          body: "404 page not found",
          headers: { 'Content-Type' => 'text/plain' }
        )
    end

    describe '#get' do
      it "raises API error for non-status 404" do
        expect{subject.get('/test')}.to raise_error(K8s::Error::API, %r(GET /test => HTTP 404 Not Found))
      end
    end
  end

  context "for a stub /api/v1/nodes" do
    before do
      stub_request(:get, 'localhost:8080/api/v1/nodes')
        .to_return(
          status: 200,
          body: fixture('api/nodes-list.json'),
          headers: { 'Content-Type' => 'application/json' }
        )
    end

    describe '#get response_class:' do
      it "returns the list" do
        list = subject.get('/api/v1/nodes',
          response_class: K8s::API::MetaV1::List,
        )

        expect(list).to be_a K8s::API::MetaV1::List
        expect(list.items).to match [
          hash_including('metadata' => hash_including('name' => 'ubuntu-xenial')),
        ]
      end
    end
  end

  context "for a 403 error" do
    before do
      stub_request(:get, 'localhost:8080/api/v1/nodes')
        .to_return(
          status: [403, "Forbidden"],
          body: fixture('api/error-forbidden.json'),
          headers: { 'Content-Type' => 'application/json' }
        )
    end

    describe '#get:' do
      it "raises Forbidden" do
        expect{subject.get('/api/v1/nodes')}.to raise_error K8s::Error::Forbidden, 'GET /api/v1/nodes => HTTP 403 Forbidden: nodes is forbidden: User "system:anonymous" cannot list nodes at the cluster scope'
      end
    end
  end

  context "for a 503 error" do
    before do
      stub_request(:get, 'localhost:8080/apis/metrics.k8s.io/v1beta1/nodes')
        .to_return(
          status: [503, "Service Unavailable"],
          body: "Error: 'context canceled'\nTrying to reach: 'https://10.250.121.71:443/apis/metrics.k8s.io/v1beta1/nodes?labelSelector=k8s.kontena.io%2Fstack%3Dweave'",
          headers: { 'Content-Type' => 'text/plain; charset=utf-8' }
        )
    end

    describe '#get' do
      it "raises ServiceUnavailable" do
        expect{subject.get('/apis/metrics.k8s.io/v1beta1/nodes')}.to raise_error K8s::Error::ServiceUnavailable, %r(GET /apis/metrics.k8s.io/v1beta1/nodes => HTTP 503 Service Unavailable: Error: 'context canceled')
      end
    end
  end

  describe '#gets' do
    context 'with HTTP 503 responses for pipelined requests' do
      before do
        stub_request(:get, 'localhost:8080/apis/metrics.k8s.io/v1beta1/pods')
          .to_return(
            status: 200,
            body: "{\"kind\":\"PodMetricsList\",\"apiVersion\":\"metrics.k8s.io/v1beta1\",\"metadata\":{\"selfLink\":\"/apis/metrics.k8s.io/v1beta1/pods\"},\"items\":[]}\n",
            headers: { 'Content-Type' => 'application/json' }
          )
        stub_request(:get, 'localhost:8080/apis/metrics.k8s.io/v1beta1/nodes')
          .to_return(
            {
              status: [503, "Service Unavailable"],
              body: "Error: 'context canceled'\nTrying to reach: 'https://10.250.121.71:443/apis/metrics.k8s.io/v1beta1/nodes?labelSelector=k8s.kontena.io%2Fstack%3Dweave'",
              headers: { 'Content-Type' => 'text/plain; charset=utf-8' },
            },
            {
              status: 200,
              body: (
                <<-EOM
                {
                  "kind": "NodeMetricsList",
                  "apiVersion": "metrics.k8s.io/v1beta1",
                  "metadata": {
                    "selfLink": "/apis/metrics.k8s.io/v1beta1/nodes"
                  },
                  "items": []
                }
                EOM
              ),
              headers: { 'Content-Type' => 'application/json' }
            },
          )
      end

      it "retries the 503 request" do
        expect(subject).to receive(:requests).once.and_call_original
        expect(subject).to receive(:request).once.with(hash_including(path: '/apis/metrics.k8s.io/v1beta1/nodes')).and_call_original

        result = subject.gets('/apis/metrics.k8s.io/v1beta1/nodes', '/apis/metrics.k8s.io/v1beta1/pods', response_class: K8s::API::MetaV1::List)

        expect(result).to match [K8s::API::MetaV1::List, K8s::API::MetaV1::List]
      end
    end
  end

  describe 'skip_missing: true' do
    context "with HTTP 404 responses" do
      before do
        stub_request(:get, 'localhost:8080/api/v1/namespaces/default/services/foo')
          .to_return(
            status: 200,
            headers: { 'Content-Type' => 'application/json' },
            body: fixture('api/services-foo.json'),
          )
        stub_request(:get, 'localhost:8080/api/v1/namespaces/default/configmaps/bar')
          .to_return(
            status: 404,
            headers: { 'Content-Type' => 'application/json' },
            body: fixture('api/configmaps-bar-404.json'),
          )
      end

      it "returns mixed resources and nils" do
        result = subject.gets(
          '/api/v1/namespaces/default/services/foo',
          '/api/v1/namespaces/default/configmaps/bar',
          skip_missing: true,
        )

        expect(result).to match [Hash, nil]
      end
    end

    context "with HTTP 403 responses" do
      before do
        stub_request(:get, 'localhost:8080/api/v1/namespaces/default/services/foo')
          .to_return(
            status: 200,
            headers: { 'Content-Type' => 'application/json' },
            body: fixture('api/services-foo.json'),
          )
        stub_request(:get, 'localhost:8080/api/v1/namespaces/default/configmaps/bar')
          .to_return(
            status: [403, "Forbidden"],
            body: fixture('api/error-forbidden.json'),
            headers: { 'Content-Type' => 'application/json' }
          )
      end

      it "raises Forbidden" do
        expect{
          subject.gets(
            '/api/v1/namespaces/default/services/foo',
            '/api/v1/namespaces/default/configmaps/bar',
            skip_missing: true,
          )
        }.to raise_error(K8s::Error::Forbidden)
      end
    end
  end

  describe 'skip_forbidden: true' do
    context "with HTTP 403 responses" do
      before do
        stub_request(:get, 'localhost:8080/api/v1/namespaces/default/services/foo')
          .to_return(
            status: 200,
            headers: { 'Content-Type' => 'application/json' },
            body: fixture('api/services-foo.json'),
          )
        stub_request(:get, 'localhost:8080/api/v1/namespaces/default/configmaps/bar')
          .to_return(
            status: [403, "Forbidden"],
            body: fixture('api/error-forbidden.json'),
            headers: { 'Content-Type' => 'application/json' }
          )
      end

      it "returns mixed resources and nils" do
        result = subject.gets(
          '/api/v1/namespaces/default/services/foo',
          '/api/v1/namespaces/default/configmaps/bar',
          skip_forbidden: true,
        )

        expect(result).to match [Hash, nil]
      end
    end

    context "with HTTP 404 responses" do
      before do
        stub_request(:get, 'localhost:8080/api/v1/namespaces/default/services/foo')
          .to_return(
            status: 200,
            headers: { 'Content-Type' => 'application/json' },
            body: fixture('api/services-foo.json'),
          )
        stub_request(:get, 'localhost:8080/api/v1/namespaces/default/configmaps/bar')
          .to_return(
            status: 404,
            headers: { 'Content-Type' => 'application/json' },
            body: fixture('api/configmaps-bar-404.json'),
          )
      end

      it "raises NotFound" do
        expect{
          subject.gets(
            '/api/v1/namespaces/default/services/foo',
            '/api/v1/namespaces/default/configmaps/bar',
            skip_forbidden: true,
          )
        }.to raise_error(K8s::Error::NotFound)
      end
    end
  end

  describe '#need_delete_body?' do
    it 'returns true if older than 1.11' do
      allow(subject).to receive(:version).and_return(double(:version, gitVersion: '1.10.4'))
      expect(subject.need_delete_body?).to be_truthy
    end

    it 'returns false if 1.11.0' do
      allow(subject).to receive(:version).and_return(double(:version, gitVersion: '1.11.0'))
      expect(subject.need_delete_body?).to be_falsey
    end

    it 'returns false newer than 1.11.0' do
      allow(subject).to receive(:version).and_return(double(:version, gitVersion: '1.11.1'))
      expect(subject.need_delete_body?).to be_falsey
    end

    it 'handles semver build metadata' do
      allow(subject).to receive(:version).and_return(double(:version, gitVersion: '1.10.1+asdasd'))
      expect(subject.need_delete_body?).to be_truthy
    end

    it 'handles semver pre-release' do
      allow(subject).to receive(:version).and_return(double(:version, gitVersion: '1.10.1-rc.1'))
      expect(subject.need_delete_body?).to be_truthy
    end
  end
end
