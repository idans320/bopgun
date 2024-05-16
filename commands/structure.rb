require_relative '../parser'
require_relative '../tokenizer'

module StructureCommand
  include Tokenizer
  include Parser
  def parse(name, project_name)
    file_name = "structures/#{name}"
    throw error("#{name} is not a valid structure") unless File.exist?(file_name)
    parse_structure_token(tokenize_structure((p File.read(file_name) % project_name)))
  end

  def list_structures
    files = Dir.entries('structures') - %w[. ..]
    puts files
  end

  def create(name, project_name, pwd)
    project_dir =  File.join pwd, project_name
    throw error('Project already exists') if Dir.exist? project_dir
    Dir.mkdir project_dir
    parsed_paths = parse(name, project_name)
    parsed_paths.each do |path|
      root_path = File.join pwd, path[0]
      file_path = File.join root_path, path[1]
      Dir.mkdir(root_path) unless Dir.exist? root_path
      File.open(file_path, 'w')
    end
  end
end
