require_relative '../dumpers/sql/sqlalchemy'
require_relative '../tokenizer'

require 'pathname'

module DumpSqlCommand
  include SqlAlchemy
  include Tokenizer
  @@modules = {
    "SqlAlchemy": SqlAlchemy.new
  }

  def dump_command(file, module_name, out_file, pwd)
    is_relative = Pathname.new(file).relative?

    file_path = is_relative ? File.join(pwd, file) : file
    parser_module = @@modules[:"#{module_name}"]

    throw error('Module does not exist') unless parser_module
    content = File.read(file_path)
    parsed = parser_module.parse(tokenize_sql(content))

    is_relative_out = Pathname.new(file).relative?
    file_path_out = is_relative_out ? File.join(pwd, out_file) : out_file

    File.write(file_path_out, parsed)
  end
end
