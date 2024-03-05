require_relative '../parser'

include Parser

describe do
  describe 'parse structure' do
    it 'should parse the tokens correctly' do

      tokens = [{:name=>'test/', :count=>0, :type=>'dir'},
                {:name=>'app/', :count=>1, :type=>'dir'},
                {:name=>'test.py', :count=>2, :type=>'file'},
                {:name=>'chow/', :count=>2, :type=>'dir'},
                {:name=>'pong.py', :count=>3, :type=>'file'},
                {:name=>'hello.py', :count=>1, :type=>'file'}
              ]
      result = parse_structure_token(tokens)
      expect(result[1][:name]).to eq('app/')
      expect(result[1][:type]).to eq('dir')
      expect(result[2][:type]).to eq('file')
    end
  end
end
