RSpec.describe K8s::Stack do
  include FixtureHelpers

  context "for a simple whoami stack" do
    let(:client) { instance_double(K8s::Client) }

    subject { described_class.load(fixture_path('stacks/whoami.yaml'), name: 'whoami') }

    context "which is not yet installed" do
      
    end
  end
end
