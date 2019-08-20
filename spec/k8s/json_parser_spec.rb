require 'k8s/json_parser/yajl'

RSpec.describe K8s::JSONParser do
  let(:json) do
    <<~E_JSON
      {"field":"value","nested_field":{"nested_key":"nested_value"},"array":["array_value"],"hash_array":[{"hash_array_key":"hash_array_value"}]}
    E_JSON
  end

  let(:expected_result) do
    {
      'field' => 'value',
      'nested_field' => { 'nested_key' => 'nested_value' },
      'array' => [ 'array_value' ],
      'hash_array' => [  { 'hash_array_key' => 'hash_array_value' } ]
    }
  end

  [:Default, :Yajl].each do |backend|
    context "K8s::JSONParser #{backend} backend" do
      subject { K8s::JSONParser.const_get(backend) }

      describe '#parse' do
        it 'correctly parses the json' do
          expect(subject.parse(json)).to eq expected_result
        end
      end

      describe 'stream parsing' do
        it 'correctly parses a stream of json' do
          result = []

          parser = subject.new do |item|
            result << item
          end

          # Feed the buffer with two complete jsons in one push, should yield two results.
          parser << json * 2
          expect(result.size).to eq 2
          result.clear

          # Feed ten json examples in random chunks into the parser, should still yield ten results
          10.times do |strlen|
            json.split('').each_slice(strlen + 1) do |slice|
              parser << slice.join
            end
          end

          expect(result.size).to eq 10
          result.each do |item|
            expect(item).to eq expected_result
          end

          result.clear

          # Feed an empty line and some empty data into the parser for good measure, should yield nothing
          parser << "\n"
          parser << "  "

          expect(result).to be_empty
        end
      end
    end
  end
end
