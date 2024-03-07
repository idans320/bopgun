require_relative '../../dumpers/sql/sqlalchemy'

include SqlAlchemy

describe do
  describe 'sqlalchemy dumps' do
    it 'dumps' do
      tokens = ['dbo.contracts',
                { 'contract_id' => ['int', false], 'subs_code' => ['nvarchar', false], 'subs_name' => ['nvarchar', false],
                  'contract_status_code' => ['int', false], 'created_date' => ['datetime', false] }]
      result = SqlAlchemy::SqlAlchemy.parse(tokens)
      result
    end
  end
end
