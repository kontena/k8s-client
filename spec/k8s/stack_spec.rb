RSpec.describe K8s::Stack do
  include FixtureHelpers

  context "for a simple whoami stack" do
    let(:client) { instance_double(K8s::Client) }

    subject { described_class.load('whoami', fixture_path('stacks/whoami.yaml')) }

    it "has the correct name" do
      expect(subject.name).to eq 'whoami'
    end

    it "has the resource" do
      expect(subject.resources.map{|r| r.to_hash}).to match [
        hash_including(
          apiVersion: 'apps/v1',
          kind: 'Deployment',
          metadata: hash_including(
            namespace: 'default',
            name: 'whoami',
          ),
        ),
        hash_including(
          apiVersion: 'v1',
          kind: 'Service',
          metadata: hash_including(
            namespace: 'default',
            name: 'whoami',
          ),
        ),
        hash_including(
          apiVersion: 'extensions/v1beta1',
          kind: 'Ingress',
          metadata: hash_including(
            namespace: 'default',
            name: 'whoami',
          ),
        ),
      ]
    end

    # XXX: Need to still fix the stack specs
    #

    # context "which is not yet installed" do
    #   let(:resources) {
    #     subject.resources
    #     # subject.resources.map{ |r|
    #     #   allow(r).to receive(:checksum).and_return('123')
    #     # }
    #   }

    #   before do
    #     allow(client).to receive(:get_resources).with([K8s::Resource, K8s::Resource, K8s::Resource]).and_return([nil, nil, nil ])
    #     allow(client).to receive(:list_resources).with(labelSelector: { 'k8s.kontena.io/stack' => 'whoami' }, skip_forbidden: true).and_return(resources)
    #   end

    #   it "creates the resource with the correct label" do
    #     resources.each do |r|
    #       expect(client).to receive(:create_resource)
    #     end

    #     subject.apply(client)
    #   end
    # end
  end

  context "with customized labels" do
    class TestStack < described_class
      LABEL = 'k8s-test.kontena.io/stack'
      CHECKSUM_ANNOTATION = 'k8s-test.kontena.io/stack-checksum'
    end

    let(:resource) {
      resource = K8s::Resource.from_file(fixture_path('resources/test/test.yaml'))
      allow(resource).to receive(:checksum).and_return('123')
      resource
    }

    subject { TestStack.new('test', [resource]) }

    it "labels resources with the correct label and annotation" do
      expect(TestStack::LABEL).to eq 'k8s-test.kontena.io/stack'
      expect(subject.class::LABEL).to eq 'k8s-test.kontena.io/stack'

      expect(subject.prepare_resource(resource).to_hash).to match hash_including(
        metadata: hash_including(
          namespace: 'default',
          name: 'test',
          labels: { :'k8s-test.kontena.io/stack' => 'test' },
          annotations: hash_including({ :'k8s-test.kontena.io/stack-checksum' => '123' })
        ),
      )
    end
  end
end
