RSpec.describe Pharos::Kube::Client do
  include FixtureHelpers


  context "for a mocked API" do
    let(:transport) { Pharos::Kube::Transport.new('http://localhost:8080') }

    subject { described_class.new(transport) }

    STUB_APIS = {
      '/version' => 'api/version.json',
      '/api/v1' => 'api/api-v1.json',
      '/apis' => 'api/apis.json',
    }

    before do
      STUB_APIS.each do |path, fixture_path|
        stub_request(:get, "localhost:8080#{path}")
        .to_return(
          status: 200,
          body: fixture(fixture_path),
          headers: { 'Content-Type' => 'application/json' }
        )
      end
    end


    describe '#version' do
      it "returns version JSON" do
        expect(subject.version).to match hash_including(
          gitVersion: 'v1.10.5',
        )
      end
    end

    describe '#api' do
      it "returns core API with resources" do
        expect(subject.api).to match Pharos::Kube::APIClient
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
        expect(subject.apis.first).to match Pharos::Kube::APIClient
        expect(subject.apis.map{|a| a.api_version}).to match(['v1'] + (
          # curl -v http://localhost:8001/apis | jq -r '.groups[].preferredVersion.groupVersion'
          <<-EOM
            apiregistration.k8s.io/v1
            extensions/v1beta1
            apps/v1
            events.k8s.io/v1beta1
            authentication.k8s.io/v1
            authorization.k8s.io/v1
            autoscaling/v1
            batch/v1
            certificates.k8s.io/v1beta1
            networking.k8s.io/v1
            policy/v1beta1
            rbac.authorization.k8s.io/v1
            storage.k8s.io/v1
            admissionregistration.k8s.io/v1beta1
            apiextensions.k8s.io/v1beta1
          EOM
        ).split)
      end
    end
  end
end
