# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task default: :spec

desc "Output the cosing database into a json format"
task :export do
  database = Cosing.load
  database.save
end
