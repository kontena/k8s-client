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

    context "which is not yet installed" do

    end
  end
end
