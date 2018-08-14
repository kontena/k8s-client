RSpec.describe K8s::APIClient do
  include FixtureHelpers

  let(:transport) { K8s::Transport.new('http://localhost:8080') }

  context "for the v1 API" do
    subject { described_class.new(transport, 'v1') }

    describe '#self.path' do
      it "returns the correct path" do
        expect(described_class.path('v1')).to eq '/api/v1'
      end
    end

    describe '#path' do
      it "returns the correct root path" do
        expect(subject.path).to eq '/api/v1'
      end

      it "returns the correct resource path" do
        expect(subject.path('tests')).to eq '/api/v1/tests'
      end
    end

    before do
      stub_request(:get, 'localhost:8080/api/v1')
      .to_return(
        status: 200,
        body: fixture('api/api-v1.json'),
        headers: { 'Content-Type' => 'application/json' }
      )
    end

    describe '#api_resources' do
      it "returns array of APIResource" do
        expect(subject.api_resources.first).to match K8s::API::MetaV1::APIResource
        expect(subject.api_resources.map{|r| r.name}).to match(
          # curl http://localhost:8001/api/v1 | jq -r '.resources[].name'
          <<-EOM
            bindings
            componentstatuses
            configmaps
            endpoints
            events
            limitranges
            namespaces
            namespaces/finalize
            namespaces/status
            nodes
            nodes/proxy
            nodes/status
            persistentvolumeclaims
            persistentvolumeclaims/status
            persistentvolumes
            persistentvolumes/status
            pods
            pods/attach
            pods/binding
            pods/eviction
            pods/exec
            pods/log
            pods/portforward
            pods/proxy
            pods/status
            podtemplates
            replicationcontrollers
            replicationcontrollers/scale
            replicationcontrollers/status
            resourcequotas
            resourcequotas/status
            secrets
            serviceaccounts
            services
            services/proxy
            services/status
          EOM
          .split
        )
      end
    end

    describe '#resource' do
      it "raises error for non-existing resource" do
        expect{subject.resource('wtfs')}.to raise_error(K8s::Error::UndefinedResource, %r(Unknown resource wtfs for v1))
      end

      it "returns client for resource name" do
        expect(subject.resource('pods').resource).to eq 'pods'
      end
    end

    describe '#client_for_resource' do
      context "for an invalid resource apiVersion" do
        let(:resource) {
          K8s::Resource.new(
            apiVersion: 'test/v1',
            kind: 'Test',
          )
        }

        it "raises error" do
          expect{subject.client_for_resource(resource)}.to raise_error(K8s::Error::UndefinedResource, %r(Invalid apiVersion=test/v1 for v1 client))
        end
      end

      context "for an invalid resource kind" do
        let(:resource) {
          K8s::Resource.new(
            apiVersion: 'v1',
            kind: 'Wtf',
          )
        }

        it "raises error" do
          expect{subject.client_for_resource(resource)}.to raise_error(K8s::Error::UndefinedResource,  %r(Unknown resource kind=Wtf for v1))
        end
      end
    end

    describe '#resources' do
      it "returns array of clients" do
        expect(subject.resources).to match Array
        expect(subject.resources.first).to match K8s::ResourceClient
      end
    end
  end
end
