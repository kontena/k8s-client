RSpec.describe K8s::Client do
  include FixtureHelpers

  describe '#config' do
    let(:config_context) {
      {
        cluster: 'kubernetes',
        user: 'test',
      }
    }

    let(:config) { K8s::Config.new(
      clusters: [
        {
          name: 'kubernetes',
          cluster: {
            server: 'http://localhost:8080',
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
          context: config_context,
        }
      ],
      current_context: 'test'
    ) }

    subject { described_class.config(config) }

    it "queries the correct server and options" do
      stub_request(:get, "localhost:8080/version")
        .with(
          headers: { 'Authorization' => 'Bearer SECRET' },
        )
        .to_return(
          status: 200,
          body: fixture('api/version.json'),
          headers: { 'Content-Type' => 'application/json' }
        )

      expect(subject.version.to_hash).to match hash_including(
        gitVersion: 'v1.10.5',
      )
    end
  end

  context "for a mocked API" do
    let(:transport) { K8s::Transport.new('http://localhost:8080') }

    subject { described_class.new(transport) }

    STUB_APIS = {
      '/version' => 'api/version.json',
      '/api/v1' => 'api/api-v1.json',
      '/apis' => 'api/apis.json',
    }

    # jq -r '.groups[].versions[].groupVersion' spec/fixtures/api/apis.json
    API_GROUPS = (
        <<-EOM
          apiregistration.k8s.io/v1
          apiregistration.k8s.io/v1beta1
          extensions/v1beta1
          apps/v1
          apps/v1beta2
          apps/v1beta1
          events.k8s.io/v1beta1
          authentication.k8s.io/v1
          authentication.k8s.io/v1beta1
          authorization.k8s.io/v1
          authorization.k8s.io/v1beta1
          autoscaling/v1
          autoscaling/v2beta1
          batch/v1
          batch/v1beta1
          certificates.k8s.io/v1beta1
          networking.k8s.io/v1
          policy/v1beta1
          rbac.authorization.k8s.io/v1
          rbac.authorization.k8s.io/v1beta1
          storage.k8s.io/v1
          storage.k8s.io/v1beta1
          admissionregistration.k8s.io/v1beta1
          apiextensions.k8s.io/v1beta1
        EOM
    ).split

    before do
      STUB_APIS.each do |path, fixture_path|
        stub_request(:get, "localhost:8080#{path}")
          .to_return(
            status: 200,
            body: fixture(fixture_path),
            headers: { 'Content-Type' => 'application/json' }
          )
      end

      for api_version in API_GROUPS
        # for api in $(jq -r '.groups[].versions[].groupVersion' spec/fixtures/api/apis.json); do curl http://localhost:8001/apis/$api > spec/fixtures/apis/${api/\//-}.json; done
        stub_request(:get, "localhost:8080/apis/#{api_version}")
          .to_return(
            status: 200,
            body: fixture("apis/#{api_version.sub('/', '-')}.json"),
            headers: { 'Content-Type' => 'application/json' }
          )
      end
    end

    describe '#config' do
      let(:config_context) {
        {
          cluster: 'kubernetes',
          user: 'test',
          namespace: 'test',
        }
      }

      let(:config) { K8s::Config.new(
        clusters: [
          {
            name: 'kubernetes',
            cluster: {
              server: 'http://localhost:8080',
            }
          }
        ],
        users: [
          {
            name: 'test',
            user: {
            }
          }
        ],

        contexts: [
          {
            name: 'test',
            context: config_context,
          }
        ],
        current_context: 'test'
      ) }

      subject { described_class.config(config) }

      describe '#client_for_resource' do
        let(:resource) { resource_fixture('resources/service-nonamespace.yaml') }

        it "uses the configured namespace as the default" do
          expect(subject.client_for_resource(resource).namespace).to eq 'test'
        end
      end
    end

    describe '#version' do
      it "returns version" do
        expect(subject.version.to_hash).to match hash_including(
          gitVersion: 'v1.10.5',
        )
      end
    end

    describe '#api' do
      it "returns core API with resources" do
        expect(subject.api).to match K8s::APIClient
        expect(subject.api.api_version).to eq 'v1'
        expect(subject.api.api_resources.map{|r| r.name }).to include 'nodes', 'pods', 'services'
      end

      it "caches api_resources" do
        expect(transport).to receive(:get).with('/api/v1', Hash).once.and_call_original

        3.times do
          expect(subject.api.api_resources.map{|r| r.name }).to include 'nodes', 'pods', 'services'
        end
      end
    end

    describe '#apis' do
      it "returns client for each api" do
        expect(subject.apis).to match Array
        expect(subject.apis.first).to match K8s::APIClient
        expect(subject.apis.map{|a| a.api_version}).to eq(['v1'] + API_GROUPS)
      end

      context "with partially cached api resources" do
        before do
          subject.api.api_resources
        end

        it "prefetches missing resources for apis" do
          expect(transport).to receive(:get).once.with('/apis', hash_including(:response_class)).and_call_original
          expect(transport).to receive(:gets).once.and_call_original

          apis = subject.apis(prefetch_resources: true)

          expect(apis.map{|api| api.api_resources}.flatten.map{|r| r.name}).to include 'nodes', 'pods', 'deployments', 'jobs'
        end
      end
    end

    describe '#create_resource' do
      context "for a service resource" do
        let(:resource) { resource_fixture('resources/service.yaml') }
        let(:server_resource) { resource.merge(
          metadata: { resourceVersion: '1'}
        ) }

        before do
          stub_request(:post, 'localhost:8080/api/v1/namespaces/default/services')
            .with(
              headers: { 'Content-Type' => 'application/json' },
              body: resource.to_hash,
            )
            .to_return(
              status: 201,
              headers: { 'Content-Type' => 'application/json' },
              body: server_resource.to_json,
            )
        end

        it "returns the created resource" do
          r = subject.create_resource(resource)

          expect(r).to match K8s::Resource
          expect(r.kind).to eq 'Service'
          expect(r.metadata.name).to eq 'whoami'
          expect(r.metadata.resourceVersion).to eq '1'
        end
      end

      context "for a service resource without a namespace" do
        let(:resource) { resource_fixture('resources/service-nonamespace.yaml') }
        let(:server_resource) { resource.merge(
          metadata: {
            namespace: 'default',
            resourceVersion: '1',
          }
        ) }

        context "using the default namespace" do
          before do
            stub_request(:post, 'localhost:8080/api/v1/namespaces/default/services')
              .with(
                headers: { 'Content-Type' => 'application/json' },
                body: resource.to_hash,
              )
              .to_return(
                status: 201,
                headers: { 'Content-Type' => 'application/json' },
                body: server_resource.to_json,
              )
          end

          it "returns the created resource" do
            r = subject.create_resource(resource)

            expect(r).to match K8s::Resource
            expect(r.kind).to eq 'Service'
            expect(r.metadata.namespace).to eq 'default'
            expect(r.metadata.name).to eq 'whoami'
            expect(r.metadata.resourceVersion).to eq '1'
          end
        end

        context "using a custom namespace" do
          subject { described_class.new(transport, namespace: 'test') }

          let(:server_resource) { resource.merge(
            metadata: {
              namespace: 'test',
              resourceVersion: '1',
            }
          ) }

          before do
            stub_request(:post, 'localhost:8080/api/v1/namespaces/test/services')
              .with(
                headers: { 'Content-Type' => 'application/json' },
                body: resource.to_hash,
              )
              .to_return(
                status: 201,
                headers: { 'Content-Type' => 'application/json' },
                body: server_resource.to_json,
              )
          end

          it "returns the created resource" do
            r = subject.create_resource(resource)

            expect(r).to match K8s::Resource
            expect(r.kind).to eq 'Service'
            expect(r.metadata.namespace).to eq 'test'
            expect(r.metadata.name).to eq 'whoami'
            expect(r.metadata.resourceVersion).to eq '1'
          end
        end
      end

      context "for a namespace resource" do
        let(:resource) { resource_fixture('resources/namespace.yaml') }
        let(:server_resource) { resource.merge(
          metadata: { resourceVersion: '1'}
        ) }

        before do
          # not namespaced, no 'default' namespace!
          stub_request(:post, 'localhost:8080/api/v1/namespaces')
            .with(
              headers: { 'Content-Type' => 'application/json' },
              body: resource.to_hash,
            )
            .to_return(
              status: 201,
              headers: { 'Content-Type' => 'application/json' },
              body: server_resource.to_json,
            )
        end

        it "returns the created resource" do
          r = subject.create_resource(resource)

          expect(r).to match K8s::Resource
          expect(r.kind).to eq 'Namespace'
          expect(r.metadata.name).to eq 'test'
          expect(r.metadata.resourceVersion).to eq '1'
        end
      end
    end

    describe '#get_resource' do
      context "for a service resource" do
        let(:resource) { resource_fixture('resources/service.yaml') }
        let(:server_resource) { resource.merge(
          metadata: { resourceVersion: '1'}
        ) }

        before do
          stub_request(:get, 'localhost:8080/api/v1/namespaces/default/services/whoami')
            .to_return(
              status: 200,
              headers: { 'Content-Type' => 'application/json' },
              body: server_resource.to_json,
            )
        end

        it "returns the server resource" do
          r = subject.get_resource(resource)

          expect(r).to match K8s::Resource
          expect(r.kind).to eq 'Service'
          expect(r.metadata.name).to eq 'whoami'
          expect(r.metadata.resourceVersion).to eq '1'
        end
      end
    end

    describe '#update_resource' do
      context "for a service resource" do
        let(:resource) { resource_fixture('resources/service.yaml').merge(
          metadata: { resourceVersion: '1'}
        ) }
        let(:server_resource) { resource_fixture('resources/service.yaml').merge(
          metadata: { resourceVersion: '2'}
        ) }

        before do
          stub_request(:put, 'localhost:8080/api/v1/namespaces/default/services/whoami')
            .with(
              headers: { 'Content-Type' => 'application/json' },
              body: resource.to_hash,
            )
            .to_return(
              status: 200,
              headers: { 'Content-Type' => 'application/json' },
              body: server_resource.to_json,
            )
        end

        it "returns the updated resource" do
          r = subject.update_resource(resource)

          expect(r).to match K8s::Resource
          expect(r.kind).to eq 'Service'
          expect(r.metadata.name).to eq 'whoami'
          expect(r.metadata.resourceVersion).to eq '2'
        end
      end
    end

    describe '#delete_resource' do
      context "for a service resource" do
        let(:resource) { resource_fixture('resources/service.yaml') }
        let(:server_resource) { resource.merge(
          metadata: { resourceVersion: '3'}
        ) }

        before do
          stub_request(:delete, 'localhost:8080/api/v1/namespaces/default/services/whoami')
            .to_return(
              status: 200,
              headers: { 'Content-Type' => 'application/json' },
              body: server_resource.to_json,
            )
        end

        it "returns the deleted resource" do
          r = subject.delete_resource(resource)

          expect(r).to match K8s::Resource
          expect(r.kind).to eq 'Service'
          expect(r.metadata.name).to eq 'whoami'
          expect(r.metadata.resourceVersion).to eq '3'
        end
      end
    end

    describe '#get_resources' do
      context "for standard resources" do
        let(:resources) {[
          K8s::Resource.from_file(fixture_path('resources/service-foo.yaml')),
          K8s::Resource.from_file(fixture_path('resources/configmap-bar.yaml')),
        ]}

        context "which already exist" do
          before do
            stub_request(:get, 'localhost:8080/api/v1/namespaces/default/services/foo')
              .to_return(
                status: 200,
                headers: { 'Content-Type' => 'application/json' },
                body: fixture('api/services-foo.json'),
              )
            stub_request(:get, 'localhost:8080/api/v1/namespaces/default/configmaps/bar')
              .to_return(
                status: 200,
                headers: { 'Content-Type' => 'application/json' },
                body: fixture('api/configmaps-bar.json'),
              )
          end

          it "prefetches API resources and pipelines the requests" do
            expect(transport).to receive(:requests).once.with(
              hash_including(path: '/api/v1'),
              skip_missing: true,
              response_class: anything,
            ).and_call_original
            expect(transport).to receive(:requests).once.with(
              hash_including(path: '/api/v1/namespaces/default/services/foo'),
              hash_including(path: '/api/v1/namespaces/default/configmaps/bar'),
              skip_missing: true,
            ).and_call_original

            r = subject.get_resources(resources)

            expect(r).to match [K8s::Resource, K8s::Resource]
            expect(r[0].to_hash).to match hash_including(
              apiVersion: 'v1',
              kind: 'Service',
            )
            expect(r[1].to_hash).to match hash_including(
              apiVersion: 'v1',
              kind: 'ConfigMap',
            )
          end
        end

        context "which may be missing" do
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

          it "returns mixed nils" do
            r = subject.get_resources(resources)

            expect(r).to match [K8s::Resource, nil]
            expect(r[0].to_hash).to match hash_including(
              apiVersion: 'v1',
              kind: 'Service',
            )
            expect(r[1]).to be nil
          end
        end
      end

      context "for custom resources" do
        let(:resources) {[
          K8s::Resource.from_file(fixture_path('resources/test/crd-test.yaml')),
          K8s::Resource.from_file(fixture_path('resources/test/test.yaml')),
        ]}

        context "which do not yet exist" do
          before do
            stub_request(:get, 'localhost:8080/apis/apiextensions.k8s.io/v1beta1/customresourcedefinitions/tests.pharos-test.k8s.io')
              .to_return(
                status: 404,
                headers: { 'Content-Type' => 'text/plain' },
                body: '404 page not found',
              )
            stub_request(:get, 'localhost:8080/apis/pharos-test.k8s.io/v0')
              .to_return(
                status: 404,
                headers: { 'Content-Type' => 'text/plain' },
                body: '404 page not found',
              )
            stub_request(:get, 'localhost:8080/apis/pharos-test.k8s.io/v0/namespaces/default/tests/test')
              .to_return(
                status: 404,
              )
          end

          it "returns nils" do
            r = subject.get_resources(resources)

            expect(r).to match [nil, nil]
          end
        end
      end
    end

    describe '#list_resources' do
      let(:service_resource) { K8s::Resource.from_file(fixture_path('resources/service-foo.yaml')) }

      context "which partially have resources" do
        before do
          stub_request(:get, 'localhost:8080/api/v1/services')
            .to_return(
              status: 200,
              headers: { 'Content-Type' => 'application/json' },
              body: {
                apiVersion: 'v1',
                kind: 'ServiceList',
                metadata: {},
                items: [service_resource],
              }.to_json,
            )
          stub_request(:get, 'localhost:8080/api/v1/configmaps')
            .to_return(
              status: 200,
              headers: { 'Content-Type' => 'application/json' },
              body: {
                apiVersion: 'v1',
                kind: 'ConfgiMapList',
                metadata: {},
                items: [],
              }.to_json,
            )
        end

        it "returns existing resources" do
          expect(subject.list_resources([
            subject.api('v1').resource('services'),
            subject.api('v1').resource('configmaps'),
          ])).to eq [service_resource]
        end
      end

      context "with partial 403 errors" do
        before do
          stub_request(:get, 'localhost:8080/api/v1/services')
            .to_return(
              status: 200,
              headers: { 'Content-Type' => 'application/json' },
              body: {
                apiVersion: 'v1',
                kind: 'ServiceList',
                metadata: {},
                items: [service_resource],
              }.to_json,
            )
          stub_request(:get, 'localhost:8080/api/v1/configmaps')
            .to_return(
              status: [403, "Forbidden"],
              body: fixture('api/error-forbidden.json'),
              headers: { 'Content-Type' => 'application/json' }
            )
        end

        it "raises Forbidden" do
          expect{
            subject.list_resources([
              subject.api('v1').resource('services'),
              subject.api('v1').resource('configmaps'),
            ])
          }.to raise_error(K8s::Error::Forbidden)
        end

        describe 'skip_forbidden: true' do
          it "returns existing resources" do
            expect(subject.list_resources(
              [
                subject.api('v1').resource('services'),
                subject.api('v1').resource('configmaps'),
              ],
              skip_forbidden: true,
            )).to eq [service_resource]
          end
        end
      end
    end
  end
end
