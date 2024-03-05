module Tokenizer
  # tokenize structure from string
  def is_dir(name)
    name.match(/.+\/$/)
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
end
