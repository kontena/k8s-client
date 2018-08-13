RSpec.describe K8s::Client do
  include FixtureHelpers

  context "for a mocked API" do
    let(:transport) { K8s::Transport.new('http://localhost:8080') }

    subject { described_class.new(transport) }

    STUB_APIS = {
      '/version' => 'api/version.json',
      '/api/v1' => 'api/api-v1.json',
      '/apis' => 'api/apis.json',
    }

    API_GROUPS = (
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
        stub_request(:get, "localhost:8080/apis/#{api_version}")
          .to_return(
            status: 200,
            body: fixture("apis/#{api_version.sub('/', '-')}.json"),
            headers: { 'Content-Type' => 'application/json' }
          )
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
            expect(transport).to receive(:requests).once.with(hash_including(path: '/api/v1'), response_class: anything).and_call_original
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
    end
  end
end
