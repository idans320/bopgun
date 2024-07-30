module TemplateCommand
  def read_template(name)
    File.read("templates/#{name}")
  end

  def parse_template(args, name)
    text = read_template(name)
    i = 0
    until i == args.length
      text.gsub!(/\$#{i + 1}/, args[i])
      i += 1
    end
    text
  end

  def list_templates
    files = Dir.entries('templates') - %w[. ..]
    puts files
  end

  def create_template(args, name, file, pwd)

    is_relative = Pathname.new(file).relative?

    file_path = is_relative ? File.join(pwd, file) : file

    template = parse_template(args, name)

    File.write(file_path, template)
  end
end
