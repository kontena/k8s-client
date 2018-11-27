RSpec.describe K8s::ResourceClient do
  include FixtureHelpers

  let(:transport) { K8s::Transport.new('http://localhost:8080') }

  context "for the nodes API" do
    let(:api_client) { K8s::APIClient.new(transport, 'v1') }
    let(:api_resource) { K8s::API::MetaV1::APIResource.new(
      name: "nodes",
      singularName: "",
      namespaced: false,
      kind: "Node",
      verbs: [
        "create",
        "delete",
        "deletecollection",
        "get",
        "list",
        "patch",
        "update",
        "watch",
      ],
      shortNames: [
        "no",
      ]
    ) }

    subject { described_class.new(transport, api_client, api_resource) }

    describe '#path' do
      it 'returns root path' do
        expect(subject.path(namespace: nil)).to eq '/api/v1/nodes'
      end

      it 'returns a path to node' do
        expect(subject.path('testNode')).to eq '/api/v1/nodes/testNode'
      end

      it 'returns a path to node subresource' do
        expect(subject.path('testNode', subresource: 'proxy')).to eq '/api/v1/nodes/testNode/proxy'
      end
    end

    context "GET /api/v1/nodes" do
      before do
        stub_request(:get, 'localhost:8080/api/v1/nodes')
          .to_return(
            status: 200,
            body: fixture('api/nodes-list.json'),
            headers: { 'Content-Type' => 'application/json' }
          )
      end

      describe '#list' do
        it "returns an array of resources" do
          list = subject.list

          expect(list).to match [K8s::Resource]
          expect(list.map{|item| {
            kind: item.kind,
            namespace: item.metadata.namespace,
            name: item.metadata.name,
          } }).to match [
            { kind: "Node", namespace: nil, name: "ubuntu-xenial" }
          ]
        end
      end
    end

    context "GET /api/v1/nodes/*" do
      before do
        stub_request(:get, 'localhost:8080/api/v1/nodes/ubuntu-xenial')
          .to_return(
            status: 200,
            body: fixture('api/nodes-get.json'),
            headers: { 'Content-Type' => 'application/json' }
          )
      end

      describe '#get' do
        it "returns a resource" do
          obj = subject.get('ubuntu-xenial')

          expect(obj).to match K8s::Resource
          expect(obj.kind).to eq "Node"
          expect(obj.metadata.namespace).to be nil
          expect(obj.metadata.name).to eq "ubuntu-xenial"
        end
      end
    end

    context "PUT /api/v1/nodes/*" do
      let(:resource) { K8s::Resource.new(
        kind: 'Node',
        metadata: { name: 'test', resourceVersion: "1" },
        spec: { unschedulable: true },
      ) }

      before do
        stub_request(:put, 'localhost:8080/api/v1/nodes/test')
          .with(
            headers: { 'Content-Type' => 'application/json' },
            body: {
              'kind' => 'Node',
              'metadata' => { 'name' => 'test', 'resourceVersion' => "1" },
              'spec' => { 'unschedulable' => true },
            },
          )
          .to_return(
            status: 200,
            headers: { 'Content-Type' => 'application/json' },
            body: JSON.generate(resource.to_hash),
          )
      end

      describe '#update_resource' do
        it "returns a resource" do
          obj = subject.update_resource(resource)

          expect(obj).to match K8s::Resource
          expect(obj.kind).to eq "Node"
          expect(obj.metadata.name).to eq "test"
        end
      end
    end

    context "POST /api/v1/nodes/" do
      let(:resource) { K8s::Resource.new(
        kind: 'Node',
        metadata: { name: 'test' },
        spec: { unschedulable: true },
      ) }

      before do
        stub_request(:post, 'localhost:8080/api/v1/nodes')
          .with(
            headers: { 'Content-Type' => 'application/json' },
            body: {
              'kind' => 'Node',
              'metadata' => { 'name' => 'test' },
              'spec' => { 'unschedulable' => true },
            },
          )
          .to_return(
            status: 201,
            headers: { 'Content-Type' => 'application/json' },
            body: JSON.generate(resource.to_hash),
          )
      end

      describe '#create_resource' do
        it "returns a resource" do
          obj = subject.create_resource(resource)

          expect(obj).to match K8s::Resource
          expect(obj.kind).to eq "Node"
          expect(obj.metadata.name).to eq "test"
        end
      end
    end
  end

  context "for the nodes status API" do
    let(:api_client) { K8s::APIClient.new(transport, 'v1') }
    let(:api_resource) { K8s::API::MetaV1::APIResource.new(
      name: "nodes/status",
      singularName: "",
      namespaced: false,
      kind: "Node",
      verbs: [
        "get",
        "patch",
        "update",
      ],
    ) }

    subject { described_class.new(transport, api_client, api_resource) }

    describe '#path' do
      it 'returns a path to node subresource' do
        expect(subject.path('test')).to eq '/api/v1/nodes/test/status'
      end
    end

    context "PUT /api/v1/nodes/*/status" do
      let(:resource) { K8s::Resource.new(
        kind: 'Node',
        metadata: { name: 'test', resourceVersion: "1" },
        status: { foo: 'bar' },
      ) }

      before do
        stub_request(:put, 'localhost:8080/api/v1/nodes/test/status')
          .with(
            headers: { 'Content-Type' => 'application/json' },
            body: {
              'kind' => 'Node',
              'metadata' => { 'name' => 'test', 'resourceVersion' => "1" },
              'status' => { 'foo' => 'bar' },
            },
          )
          .to_return(
            status: 200,
            headers: { 'Content-Type' => 'application/json' },
            body: JSON.generate(resource.to_hash),
          )
      end

      describe '#update_resource' do
        it "returns a resource" do
          obj = subject.update_resource(resource)

          expect(obj).to match K8s::Resource
          expect(obj.kind).to eq "Node"
          expect(obj.metadata.name).to eq "test"
        end
      end
    end
  end

  context "for the pods API" do
    let(:api_client) { K8s::APIClient.new(transport, 'v1') }
    let(:api_resource) { K8s::API::MetaV1::APIResource.new(
      name: "pods",
      singularName: "",
      namespaced: true,
      kind: "Pod",
      verbs: [
        "create",
        "delete",
        "deletecollection",
        "get",
        "list",
        "patch",
        "update",
        "watch",
      ],
      shortNames: [
        "po",
      ],
      categories: [
        "all",
      ]
    ) }

    subject { described_class.new(transport, api_client, api_resource) }

    let(:resource) { K8s::Resource.new(
      kind: 'Pod',
      metadata: { name: 'test', namespace: 'default' },
    ) }
    let(:resource_list) { K8s::API::MetaV1::List.new(metadata: {}, items: [resource]) }

    context "POST /api/v1/pods/namespaces/default/pods" do
      before do
        stub_request(:post, 'localhost:8080/api/v1/namespaces/default/pods')
          .with(
            headers: { 'Content-Type' => 'application/json' },
            body: {
              'kind' => 'Pod',
              'metadata' => { 'name' => 'test', 'namespace' => 'default' },
            },
          )
          .to_return(
            status: 201,
            headers: { 'Content-Type' => 'application/json' },
            body: JSON.generate(resource.to_hash),
          )
      end

      describe '#create_resource' do
        it "returns a resource" do
          obj = subject.create_resource(resource)

          expect(obj).to match K8s::Resource
          expect(obj.kind).to eq "Pod"
          expect(obj.metadata.namespace).to eq "default"
          expect(obj.metadata.name).to eq "test"
        end
      end
    end

    context "PATCH /api/v1/pods/namespaces/default/pods/test" do
      before do
        stub_request(:patch, 'localhost:8080/api/v1/namespaces/default/pods/test')
          .with(
            headers: { 'Content-Type' => 'application/strategic-merge-patch+json' },
            body: {
              'spec' => { 'nodeName': 'foo' },
            }.to_json, # XXX: webmock doesn't understand +json
          )
          .to_return(
            status: 201,
            headers: { 'Content-Type' => 'application/json' },
            body: JSON.generate(resource.to_hash),
          )
      end

      describe '#merge_patch' do
        it "returns a resource" do
          obj = subject.merge_patch('test', {'spec' => { 'nodeName' => 'foo'}}, namespace: 'default')

          expect(obj).to match K8s::Resource
          expect(obj.kind).to eq "Pod"
          expect(obj.metadata.namespace).to eq "default"
          expect(obj.metadata.name).to eq "test"
        end
      end
    end

    context "DELETE /api/v1/pods/*" do
      before do
        stub_request(:delete, 'localhost:8080/api/v1/namespaces/default/pods/test')
          .to_return(
            status: 200,
            body: JSON.generate(resource.to_hash),
            headers: { 'Content-Type' => 'application/json' }
          )
        stub_request(:delete, 'localhost:8080/api/v1/namespaces/default/pods?labelSelector=app=test')
          .to_return(
            status: 200,
            body: JSON.generate(resource_list.to_hash), # XXX: to_json?
            headers: { 'Content-Type' => 'application/json' }
          )
      end

      describe '#delete' do
        it "deletes a resource and returns it" do
          obj = subject.delete('test', namespace: 'default')

          expect(obj).to match K8s::Resource
          expect(obj.kind).to eq "Pod"
          expect(obj.metadata.name).to eq "test"
        end
      end

      describe '#delete_collection' do
        it "deletes resources and returns them" do
          items = subject.delete_collection(namespace: 'default', labelSelector: 'app=test')

          expect(items).to match [K8s::Resource]
          expect(items[0].kind).to eq "Pod"
          expect(items[0].metadata.name).to eq "test"
        end
      end

      describe '#delete_resource' do
        it "deletes a resource and returns it" do
          obj = subject.delete_resource(resource)

          expect(obj).to match K8s::Resource
          expect(obj.kind).to eq "Pod"
          expect(obj.metadata.name).to eq "test"
        end
      end
    end

    context 'GET /api/v1/pods/*' do
      describe '#watch' do
        it 'configures transport for streaming request' do
          expect(transport).to receive(:request).with(
            hash_including(
              method: 'GET',
              read_timeout: nil,
              query: hash_including(
                'watch' => '1'
              ),
              response_block: kind_of(Proc)
            )
          )
          subject.watch
        end

        it 'sets timeout if given' do
          expect(transport).to receive(:request).with(
            hash_including(
              query: hash_including(
                'watch' => '1',
                'timeoutSeconds' => 60
              )
            )
          )
          subject.watch(timeout: 60)
        end
      end
    end
  end
end
