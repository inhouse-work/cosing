# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "memory_profiler"

RSpec::Core::RakeTask.new(:spec)

task default: :spec

desc "Runs a memory profile of the cosing database"
task :memory do
  report = MemoryProfiler.report do
    Cosing.load
  end

  report.pretty_print
end

desc "Output the cosing database into a json format"
task :export do
  database = Cosing.load
  database.save
end
