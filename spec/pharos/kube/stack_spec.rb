RSpec.describe Pharos::Kube::Stack do
  include FixtureHelpers

  context "for a simple whoami stack" do
    let(:client) { instance_double(Pharos::Kube::Client) }

    subject { described_class.load(fixture_path('stacks/whoami.yaml'), name: 'whoami') }

    context "which is not yet installed" do
      before do
        allow(client).to receive(:get_resource).with(Pharos::Kube::Resource).and_raise(Pharos::Kube::Error::NotFound.new(404, Pharos::Kube::API::MetaV1::Status.new(metadata: {}, message: "Not Found")))
      end

      describe '#apply' do
        it "creates the resources with the appropriate labels and annotations" do
          expect(client).to receive(:create_resource).once do |resource|
            expect(resource.apiVersion).to eq 'apps/v1'
            expect(resource.kind).to eq 'Deployment'
            expect(resource.metadata.name).to eq 'whoami'
            expect(resource.metadata.labels).to match hash_including(
              'app'.to_sym => 'whoami',
              'pharos.kontena.io/stack'.to_sym => 'whoami',
            )
          end

          expect(client).to receive(:create_resource).once do |resource|
            expect(resource.apiVersion).to eq 'v1'
            expect(resource.kind).to eq 'Service'
            expect(resource.metadata.name).to eq 'whoami'
            expect(resource.metadata.labels).to match hash_including(
              'app'.to_sym => 'whoami',
              'pharos.kontena.io/stack'.to_sym => 'whoami',
            )
          end

          expect(client).to receive(:create_resource).once do |resource|
            expect(resource.apiVersion).to eq 'extensions/v1beta1'
            expect(resource.kind).to eq 'Ingress'
            expect(resource.metadata.name).to eq 'whoami'
            expect(resource.metadata.labels).to match hash_including(
              'pharos.kontena.io/stack'.to_sym => 'whoami',
            )
          end

          subject.apply(client, prune: false)
        end
      end
    end
  end
end
