#!/usr/bin/env ruby
require 'thor'
require_relative './commands/structure'

$pwd = Dir.pwd

current_dir = __dir__
Dir.chdir(current_dir)

class Structure < Thor
  include StructureCommand
  desc 'new NAME, PROJECT_NAME', 'Create a directory strucutre under a certain project name'
  def new(name, project_name)
    create(name, project_name, $pwd)
  end
end

class BopGun < Thor
  desc 'bopgun structure', 'create a project structure'
  subcommand 'structure', Structure
  def self.exit_on_failure?
    true
  end
end

BopGun.start
