RSpec.describe Pharos::Kube::Stack do
  include FixtureHelpers

  context "for a simple whoami stack" do
    let(:client) { instance_double(Pharos::Kube::Client) }

    subject { described_class.load(fixture_path('stacks/whoami.yaml'), name: 'whoami') }

    context "which is not yet installed" do
      
    end
  end
end
