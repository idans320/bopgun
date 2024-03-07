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
  describe 'check sql token' do
    it 'should return the sql token' do
      result = tokenize_sql("CREATE TABLE [dbo].[contracts](
        [contract_id] [int] NOT NULL,
        [subs_code] nvarchar NOT NULL,
        [subs_name] nvarchar NULL,
        [contract_status_code] [int] NOT NULL,
        [created_date] [datetime] NOT NULL,
        [updated_date] [datetime] NOT NULL
        ")
      expect(result[1].member?('contract_id')).to eq(true)
    end
  end
end
