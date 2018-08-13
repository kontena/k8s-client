RSpec.describe K8s::Util do
  describe '#compact_map' do
    it "returns an empty array for an empty array" do
      expect(described_class.compact_map([]) { |args| args.map(&:to_s) }).to eq []
    end

    it "returns an array of nil for an array of nil" do
      expect(described_class.compact_map([nil]) { |args| args.map(&:to_s) }).to eq [nil]
    end

    it "translates non-nil values" do
      expect(described_class.compact_map([1]) { |args| args.map(&:to_s) }).to eq ['1']
    end

    it "translates non-nil values and passes through nil values" do
      expect(described_class.compact_map([nil, 1]) { |args| args.map(&:to_s) }).to eq [nil, '1']
    end

    it "handles duplicates" do
      expect(described_class.compact_map([nil, 1, 2, 1]) { |args| args.map(&:to_s) }).to eq [nil, '1', '2', '1']
    end
  end
end
