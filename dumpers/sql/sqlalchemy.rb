require 'dry/inflector'

module SqlAlchemy
  @@inflector = Dry::Inflector.new
  @@types = {
    'int': 'Integer',
    'bigint': 'BigInteger',
    'smallint': 'SmallInteger',
    'tinyint': 'SmallInteger', # Depending on the use case', you might choose SmallInteger or Boolean
    'decimal': 'Numeric',
    'numeric': 'Numeric',
    'float': 'Float',
    'real': 'Float',
    'char': 'String',
    'varchar': 'String',
    'text': 'Text',
    'nvarchar': 'Unicode',
    'nchar': 'Unicode',
    'datetime': 'DateTime',
    'date': 'Date',
    'time': 'Time',
    'bit': 'Boolean',
    'binary': 'LargeBinary',
    'varbinary': 'LargeBinary'
  }
  class SqlAlchemy
    def self.class_format(name)
      @@inflector.classify(name)
    end

    def self.table_name_format(name)
      @@inflector.tableize(name.sub(/dbo\./, ''))
    end

    def self.parse(tokens)
      table_name, columns = tokens
      table_name = table_name_format(table_name)
      class_name = class_format(table_name)
      str = "class #{class_name}(Base):\n\t__tablename__ = '#{table_name}'"
      columns.each do |key, value|
        type, nullable = value
        str += "\n\t#{key} = Column(#{@@types[:"#{type.downcase}"]}, nullable = #{nullable})"
      end
      str
    end
  end
end
