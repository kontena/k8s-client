RSpec.describe K8s::Resource do
  include FixtureHelpers

  context "for a simple service resource" do
    subject { described_class.from_file(fixture_path('resources/service.yaml')) }

    it "loads the correct attributes" do
      expect(subject.apiVersion).to eq 'v1'
      expect(subject.kind).to eq 'Service'
      expect(subject.metadata.namespace).to eq 'default'
      expect(subject.metadata.name).to eq 'whoami'
      expect(subject.metadata.labels['app']).to eq 'whoami'
      expect(subject.spec.selector.to_hash).to eq({ :app => 'whoami' })
      expect(subject.spec.ports).to match Array
      expect(subject.spec.ports.first.port).to eq 80
      expect(subject.spec.ports.first.protocol).to eq 'TCP'
      expect(subject.spec.ports.first.targetPort).to eq 8000
    end

    describe "#to_json" do
      it "returns the correct JSON for the kube API" do
        expect(JSON.parse(subject.to_json)).to eq({
          'apiVersion' => 'v1',
          'kind' => 'Service',
          'metadata' => {
            'namespace' => 'default',
            'name' => 'whoami',
            'labels' => { 'app' => 'whoami' },
          },
          'spec' => {
            'selector' => { 'app' => 'whoami' },
            'ports' => [
              { 'port' => 80, 'protocol' => 'TCP', 'targetPort' => 8000 },
            ],
          },
        })
      end
    end

    describe '#merge' do
      it "returns a new copy with deep-merged attributes" do
        clone = subject.merge({metadata: { name: 'whoami2' }})

        expect(subject.metadata.name).to eq 'whoami'
        expect(clone.metadata.name).to eq 'whoami2'
      end

      it "merges label hashes" do
        clone = subject.merge({metadata: { labels: { 'test' => 'true' } }})

        expect(clone.metadata.labels.to_hash).to eq({
          :app => 'whoami',
          :test => 'true',
        })
      end

      it "merges with a modified copy" do
        other = described_class.from_file(fixture_path('resources/service_modified.yaml'))
        clone = subject.merge(other.to_hash)

        expect(clone.to_hash).to eq(
          apiVersion: 'v1',
          kind: 'Service',
          metadata: {
            namespace: 'default',
            name: 'whoami2',
            labels: { app: 'whoami', app2: 'whoami2' },
          },
          spec: {
            selector: { app: 'whoami', app2: 'whoami2' }, # XXX: orly
            ports: [
              { port: 80, protocol: 'TCP', targetPort: 8001 },
            ]
          },
        )
      end

      it "merges array object" do
        clone = subject.merge(
          spec: {
            ports: [
              { port: 80, protocol: 'TCP', targetPort: 8001 },
            ],
          }
        )

        expect(clone.to_hash[:spec][:ports]).to eq [
          { port: 80, protocol: 'TCP', targetPort: 8001 },
        ]
      end
    end

    describe "#==" do
      it "compares equal to itself" do
        expect(subject == subject).to be_truthy
      end

      it "compares equal to a JSON-roundtripped copy of the same resource" do
        expect(subject == described_class.from_json(subject.to_json)).to be_truthy
      end

      it "does not compare equal to a merged copy" do
        expect(subject != subject.merge(metadata: { name: 'whoami2' })).to be_truthy
      end

      it "compares equal to an identical merged copy" do
        expect(subject == subject.merge(metadata: { name: 'whoami' })).to be_truthy
        expect(subject != subject.merge(metadata: { name: 'whoami' })).to be_falsey
      end
    end
  end

  describe "for multiple resource files" do
    let(:resources) { described_class.from_files(fixture_path('resources/test')) }

    it "loads multiple resources in order" do
      expect(resources).to match [K8s::Resource, K8s::Resource]
      expect(resources.map{|r| "#{r.kind}:#{r.metadata.name}" }).to eq [
        'CustomResourceDefinition:tests.pharos-test.k8s.io',
        'Test:test',
      ]
    end
  end

  describe "#checksum" do
    subject { described_class.from_file(fixture_path('resources/service.yaml')) }

    it 'has a checksum' do
      expect(subject.checksum).not_to be_nil
    end

    it 'changes checksum when attributes change' do
      before = subject.checksum
      merged = subject.merge(metadata: { labels: {'foo' => 'bar'}})
      after = merged.checksum

      expect(before).not_to eq(after)
    end
  end

  describe "#current_config" do
    subject { described_class.from_file(fixture_path('resources/service.yaml')) }

    it 'returns empty hash by default' do
      expect(subject.current_config('foo')).to eq({})
    end

    it 'returns config object' do
      config = JSON.parse(JSON.dump(subject.to_hash))
      subject.metadata['annotations'] = {
        'foo' => JSON.dump(config)
      }
      expect(subject.current_config('foo')).to eq(config)
    end

    it 'removes kubectl set empty metadata.namespace' do
      config = JSON.parse(JSON.dump(subject.to_hash))
      config['metadata']['namespace'] = ''
      subject.metadata['annotations'] = {
        'foo' => JSON.dump(config)
      }
      expect(subject.current_config('foo')['metadata'].has_key?('namespace')).to be_falsey
    end
  end
end
