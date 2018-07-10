RSpec.describe Pharos::Kube::ResourceClient do
  include FixtureHelpers

  let(:transport) { Pharos::Kube::Transport.new('http://localhost:8080') }

  context "for the nodes API" do
    let(:api_client) { Pharos::Kube::APIClient.new(transport, 'v1') }
    let(:api_resource) { Pharos::Kube::API::MetaV1::APIResource.new(
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
        expect(subject.path('testNode', 'proxy')).to eq '/api/v1/nodes/testNode/proxy'
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

          expect(list).to match [Pharos::Kube::Resource]
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

          expect(obj).to match Pharos::Kube::Resource
          expect(obj.kind).to eq "Node"
          expect(obj.metadata.namespace).to be nil
          expect(obj.metadata.name).to eq "ubuntu-xenial"
        end
      end
    end

    context "UPDATE /api/v1/nodes/*" do
      let(:resource) { Pharos::Kube::Resource.new(
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

          expect(obj).to match Pharos::Kube::Resource
          expect(obj.kind).to eq "Node"
          expect(obj.metadata.name).to eq "test"
        end
      end
    end
  end

  context "for the pods API" do
    let(:api_client) { Pharos::Kube::APIClient.new(transport, 'v1') }
    let(:api_resource) { Pharos::Kube::API::MetaV1::APIResource.new(
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

    context "DELETE /api/v1/pods/*" do
      let(:resource) { Pharos::Kube::Resource.new(
        kind: 'Pod',
        metadata: { namespace: 'kube-system', name: 'test' }
      ) }
      let(:resource_list) { Pharos::Kube::API::MetaV1::List.new(metadata: {}, items: [resource]) }

      before do
        stub_request(:delete, 'localhost:8080/api/v1/namespaces/kube-system/pods/test')
          .to_return(
            status: 200,
            body: JSON.generate(resource.to_hash),
            headers: { 'Content-Type' => 'application/json' }
          )
        stub_request(:delete, 'localhost:8080/api/v1/namespaces/kube-system/pods?labelSelector=app=test')
          .to_return(
            status: 200,
            body: JSON.generate(resource_list.to_hash), # XXX: to_json?
            headers: { 'Content-Type' => 'application/json' }
          )
      end

      describe '#delete' do
        it "deletes a resource and returns it" do
          obj = subject.delete('test', namespace: 'kube-system')

          expect(obj).to match Pharos::Kube::Resource
          expect(obj.kind).to eq "Pod"
          expect(obj.metadata.name).to eq "test"
        end
      end

      describe '#delete_collection' do
        it "deletes resources and returns them" do
          items = subject.delete_collection(namespace: 'kube-system', labelSelector: 'app=test')

          expect(items).to match [Pharos::Kube::Resource]
          expect(items[0].kind).to eq "Pod"
          expect(items[0].metadata.name).to eq "test"
        end
      end

      describe '#delete_resource' do
        it "deletes a resource and returns it" do
          obj = subject.delete_resource(resource)

          expect(obj).to match Pharos::Kube::Resource
          expect(obj.kind).to eq "Pod"
          expect(obj.metadata.name).to eq "test"
        end
      end
    end
  end
end
