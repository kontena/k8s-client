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

  describe '#json_patch' do
    it 'handles inner hash addition' do
      a = {
        metadata: {
          labels: {
            foo: 'bar'
          }
        }
      }
      b = {
        metadata: {
          labels: {
            foo: 'bar',
            another: 'label'
          }
        }
      }

      expect(described_class.json_patch(a, b)).to eq([{op: 'add', path: '/metadata/labels/another', value: 'label'}])
    end

    it 'handles inner hash removal' do
      a = {
        metadata: {
          labels: {
            foo: 'bar'
          }
        }
      }
      b = {
        metadata: {
          labels: { }
        }
      }

      expect(described_class.json_patch(a, b)).to eq([{op: 'remove', path: '/metadata/labels/foo'}])
    end

    it 'handles complete label change' do
      a = {
        metadata: {
          labels: {
            foo: 'bar'
          }
        }
      }
      b = {
        metadata: {
          labels: {
            bar: 'foo'
          }
        }
      }

      expect(described_class.json_patch(a, b)).to eq([{:op=>"remove", :path=>"/metadata/labels/foo"}, {:op=>"add", :path=>"/metadata/labels/bar", :value=>"foo"}])
    end

    it 'handles single label value change' do
      a = {
        metadata: {
          labels: {
            foo: 'bar'
          }
        }
      }
      b = {
        metadata: {
          labels: {
            foo: 'foo'
          }
        }
      }

      expect(described_class.json_patch(a, b)).to eq([{:op=>"replace", :path=>"/metadata/labels/foo", value: 'foo'}])
    end

    it 'handles array addition' do
      a = {
        ports: [
          {
            name: 'foo',
            port: 80,
            targetPort: 80,
          }
        ]
      }
      b = {
        ports: [
          {
            name: 'foo',
            port: 80,
            targetPort: 80,
          },
          {
            name: 'bar',
            port: 90,
            targetPort: 90,
          }
        ]
      }
      expect(described_class.json_patch(a, b)).to eq([{op:'add', path:'/ports/1', value:{name: 'bar', port: 90, targetPort: 90}}])
    end

    it 'handles keys with /' do
      a = {
        annotations: {
          'kubectl.kubernetes.io/last-applied-configuration' => 'a'
        }
      }
      b = {
        annotations: {
          'kubectl.kubernetes.io/last-applied-configuration' => 'b'
        }
      }
      expect(described_class.json_patch(a, b)).to eq([
        {
          op:'replace', 
          path:'/annotations/kubectl.kubernetes.io~1last-applied-configuration',
          value: 'b'
        }
      ])
    end

    it 'handles array removal' do
      a = {
        ports: [
          {
            name: 'foo',
            port: 80,
            targetPort: 80,
          },
          {
            name: 'bar',
            port: 90,
            targetPort: 90,
          }
        ]
      }
      b = {
        ports: [
          {
            name: 'foo',
            port: 80,
            targetPort: 80,
          }
        ]
      }
      expect(described_class.json_patch(a, b)).to eq([{op:'remove', path:'/ports/1'}])
    end

    it 'handles array element change' do

      a = {
        ports: [
          {
            name: 'foo',
            port: 80,
            targetPort: 80,
          },
          {
            name: 'bar',
            port: 90,
            targetPort: 90,
          }
        ]
      }
      b = {
        ports: [
          {
            name: 'foo',
            port: 80,
            targetPort: 80,
          },
          {
            name: 'bar',
            port: 9090,
            targetPort: 9090,
          }
        ]
      }
      expected_ops = [
        {op:'remove', path:'/ports/1'},
        {op:'add', path:'/ports/1', value:{name: 'bar', port: 9090, targetPort: 9090}}
      ]

      expect(described_class.json_patch(a, b)).to eq(expected_ops)
    end
  end
end
