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
      let(:resources) {
        subject.resources
      }

      before do
        allow(client).to receive(:get_resources).with([K8s::Resource, K8s::Resource, K8s::Resource]).and_return([nil, nil, nil ])
        allow(client).to receive(:list_resources).with(labelSelector: { 'k8s.kontena.io/stack' => 'whoami' }, skip_forbidden: true).and_return(resources)
      end

      it "creates the resource with the correct label" do
        resources.each do |r|
          expect(client).to receive(:create_resource) { |r| r }
        end

        subject.apply(client)
      end
    end

    context "which is partially installed" do
      let(:resources) {
        subject.resources
      }

      before do
        returned_resources = resources[0..-2].map(&:dup)
        returned_resources.each { |r| subject.prepare_resource(r) }
        allow(client).to receive(:get_resources).with([K8s::Resource, K8s::Resource, K8s::Resource]).and_return(returned_resources)
        allow(client).to receive(:list_resources).with(labelSelector: { :'k8s.kontena.io/stack' => 'whoami' }, skip_forbidden: true).and_return(returned_resources)
      end

      it "creates the missing resource" do
        expect(client).to receive(:create_resource) { |r|
          expect(r.kind).to eq(resources[-1].kind)
          r
        }
        subject.apply(client, prune: false)
      end
    end

    context "which has extra resources on server" do
      let(:resources) {
        subject.resources
      }

      before do
        extra_resource = subject.prepare_resource(subject.resources.pop)
        returned_resources = resources.dup
        returned_resources = returned_resources.map { |r| subject.prepare_resource(r) unless r.nil? }
        allow(client).to receive(:get_resources).with([K8s::Resource, K8s::Resource]).and_return(returned_resources)
        allow(client).to receive(:list_resources).with(labelSelector: { 'k8s.kontena.io/stack' => 'whoami' }, skip_forbidden: true).and_return(returned_resources + [extra_resource])
      end

      it "deletes the extra resource" do
        expect(client).to receive(:delete_resource) { |r|
          expect(r.kind).to eq('Ingress')
          expect(r.metadata.name).to eq('whoami')
          r
        }
        subject.apply(client, prune: true)
      end
    end

    context "which needs updating" do
      let(:resources) {
        subject.resources
      }

      before do
        returned_resources = resources.dup
        returned_resources = returned_resources.map { |r| subject.prepare_resource(r) unless r.nil? }
        allow(client).to receive(:get_resources).with([K8s::Resource, K8s::Resource, K8s::Resource]).and_return(returned_resources)
      end

      it "patches the needed resource" do
        subject.resources[0] = subject.resources[0].merge(metadata: { labels: {'foo' => 'bar'}})
        expect(client).to receive(:patch_resource) { |resource, ops|
          expect(ops).to include({op:'add',  path: '/metadata/labels/foo', value: 'bar'})
          resource
        }
        subject.apply(client, prune: false)
      end

      it "updates the needed resource even when annotations missing" do
        returned_resources = resources.dup
        returned_resources = returned_resources.map { |r| subject.prepare_resource(r) unless r.nil? }
        returned_resources[0].metadata.annotations = nil
        allow(client).to receive(:get_resources).with([K8s::Resource, K8s::Resource, K8s::Resource]).and_return(returned_resources)

        subject.resources[0] = subject.resources[0].merge(metadata: { labels: {'foo' => 'bar'}})
        expect(client).to receive(:update_resource) { |r| r }
        subject.apply(client, prune: false)
      end
    end

    context "prunes namespaced objects first" do
      let(:resources) {
        subject.resources
      }

      before do
        returned_resources = resources.dup
        # Make sure "server" returns namespace as first
        returned_resources.unshift(resource_fixture('resources/namespace.yml'))
        returned_resources = returned_resources.map { |r| subject.prepare_resource(r) unless r.nil? }
        allow(client).to receive(:get_resources).and_return(returned_resources)
        allow(client).to receive(:list_resources).with(labelSelector: { 'k8s.kontena.io/stack' => 'whoami' }, skip_forbidden: true).and_return(returned_resources)
      end

      it "deletes the extra resource" do
        # "empty" stack, just to remove everything from server
        test_stack = K8s::Stack.new('whoami', [])
        # Add expectations in order
        expect(client).to receive(:delete_resource) { |r|
          expect(r.kind).to eq('Deployment')
          expect(r.metadata.name).to eq('whoami')
          expect(r.metadata.namespace).to eq('default')
          r
        }
        expect(client).to receive(:delete_resource) { |r|
          expect(r.kind).to eq('Service')
          expect(r.metadata.name).to eq('whoami')
          expect(r.metadata.namespace).to eq('default')
          r
        }
        expect(client).to receive(:delete_resource) { |r|
          expect(r.kind).to eq('Ingress')
          expect(r.metadata.name).to eq('whoami')
          expect(r.metadata.namespace).to eq('default')
          r
        }
        expect(client).to receive(:delete_resource) { |r|
          expect(r.kind).to eq('Namespace')
          expect(r.metadata.name).to eq('test-namespace')
          r
        }

        test_stack.apply(client, prune: true)
      end
    end
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
