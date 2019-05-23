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

          # Feed ten json examples in random chunks into the parser
          10.times do |strlen|
            json.split('').each_slice(strlen + 1) do |slice|
              parser << slice.join
            end
          end
          # Feed empty line and empty data into the parser for good measure
          parser << "\n"
          parser << ""

          expect(result.size).to eq 10
          result.each do |item|
            expect(item).to eq expected_result
          end
        end
      end
    end
  end
end
