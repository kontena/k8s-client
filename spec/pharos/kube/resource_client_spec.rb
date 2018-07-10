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

    context "for a stub /api/v1/nodes" do
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

    context "for a stub /api/v1/nodes/*" do
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
  end
end
