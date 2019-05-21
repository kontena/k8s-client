RSpec.describe K8s::HashStruct do
  describe '#self.to_hash_struct' do
    it 'converts a hash into a hash struct' do
      expect(described_class.new(foos: [{bar: 'baz'}]).foos.first.bar).to eq 'baz'
    end
  end

  context 'getters' do
    context 'for a flat hash' do
      subject { described_class.new(foo: 'bar', bar: 'baz') }
      it 'returns value for a key using a method call' do
        expect(subject.foo).to eq 'bar'
        expect(subject.bar).to eq 'baz'
      end
    end

    context 'for a nested hash' do
      subject { described_class.new(foo: { bar: 'baz' }) }
      it 'returns value for a key using a method call' do
        expect(subject.foo.bar).to eq 'baz'
      end
    end

    context 'for a hash with an array including hashes' do
      subject { described_class.new(foo: [{ bar: 'baz' }]) }
      it 'returns value for a key using a method call' do
        expect(subject.foo.first.bar).to eq 'baz'
      end
    end
  end

  context 'setters' do
    context 'for a flat hash' do
      subject { described_class.new(foo: 'bar') }
      it 'sets a value and returns it using method calls' do
        subject.bar = 'baz'
        expect(subject.bar).to eq 'baz'
      end
    end

    context 'for a nested hash' do
      subject { described_class.new }
      it 'sets a value and returns it using method calls' do
        subject.foo = { bar: 'baz'}
        expect(subject.foo.bar).to eq 'baz'
      end
    end

    context 'for a hash with an array including hashes' do
      subject { described_class.new }
      it 'sets a value and returns it using method calls' do
        subject.foo = [{ bar: 'baz'}]
        expect(subject.foo.first.bar).to eq 'baz'
      end

      it 'allows pushing into the array and set a value and retur  it using method calls' do
        subject.foo = []
        subject.foo << { bar: 'baz' }
        expect(subject.foo.first.bar).to eq 'baz'
      end
    end
  end
end
