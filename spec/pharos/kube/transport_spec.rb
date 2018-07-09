RSpec.describe Pharos::Kube::Transport do
  describe '#self.config' do

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
