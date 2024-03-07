module Tokenizer
  # tokenize structure from string
  def is_dir(name)
    name.match(%r{.+/$})
  end

  def tokenize_structure(s)
    tokens = []
    s.each_line do |line|
      next unless line.scan(/\w/).count.positive?

      space_count = line.scan(/\|/).count
      name = if space_count.positive?
               line.match(/\|\s*__\s*(.+)/)[1]
             else
               line
             end
      type = is_dir(name) ? 'dir' : 'file'
      tokens.push({ name: name.chomp, count: space_count, type: type })
    end
    tokens
  end

  def tokenize_sql(sql_statement)
    sql_statement = sql_statement.gsub(/\[|\]/, '').gsub(/\n/, '').strip.squeeze(' ')
    pattern = /CREATE TABLE (.+)\(\s(.+)\ (.+)[,|)]/
    match = sql_statement.match(pattern)
    table_name = match[1]
    columns_with_types = match[2].strip.split(/\s*,\s*/)
    # Initialize an empty hash to store column names and types
    columns = {}

    # Iterate through columns and extract name and type
    columns_with_types.each do |column_with_type|
      column_name, column_type, column_nullable = column_with_type.split(/\s+/, 3)
      columns[column_name] = column_type, (column_nullable == 'NULL')
    end
    [table_name, columns]
  end
end
