RSpec.describe Pharos::Kube::Transport do
  include FixtureHelpers

  describe '#self.config' do
    context 'for a typical kubeadm admin.conf' do
      let(:server_cert) { OpenSSL::X509::Certificate.new fixture('config/kubeadm-apiserver-cert.pem') }

      subject { described_class.config(Pharos::Kube::Config.load_file(fixture_path('config/kubeadm-admin.conf')))}

      it 'uses the correct server' do
        expect(subject.server).to eq 'https://192.168.56.11:6443'
      end

      it 'uses the correct options' do
        expect(subject.options).to match(
          ssl_cert_store: OpenSSL::X509::Store,
          client_cert_data: /^-----BEGIN CERTIFICATE-----\n/,
          client_key_data: /^-----BEGIN RSA PRIVATE KEY-----\n/,
        )
      end

      it 'uses an ssl_cert_store that verifies the server cert' do
        expect(subject.options[:ssl_cert_store].verify(server_cert)).to eq true
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

  context "for a stub /test" do
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
          response_class: Pharos::Kube::API::MetaV1::List,
        )

        expect(list).to be_a Pharos::Kube::API::MetaV1::List
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
          status: 403,
          body: fixture('api/error-forbidden.json'),
          headers: { 'Content-Type' => 'application/json' }
        )
    end

    describe '#get:' do
      it "raises Forbidden" do
        expect{subject.get('/api/v1/nodes')}.to raise_error Pharos::Kube::Error::Forbidden, 'nodes is forbidden: User "system:anonymous" cannot list nodes at the cluster scope'
      end
    end
  end
end
