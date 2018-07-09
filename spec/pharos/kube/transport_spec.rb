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
end
