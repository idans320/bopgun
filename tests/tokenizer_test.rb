# frozen_string_literal: true

require_relative '../tokenizer'

include Tokenizer

describe do
  describe 'check structure token' do
    it 'should return the right token array' do
      result = tokenize_structure("test/
        | __ app/
        |   | __ test.py
        | __ hello.py
        ")
      expect(result[1][:name]).to eq('app/')
      expect(result[1][:type]).to eq('dir')
      expect(result[2][:type]).to eq('file')
    end
  end
end
