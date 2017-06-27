require 'bundler/setup'
require 'bundler/gem_tasks'

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.verbose = true
end
task :default => :test

task :cov do
  ENV["COV"] = "1"
  Rake::Task[:test].invoke
end

require 'rdoc/task'
require './lib/business_time_multical/version'
Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "business_time-multical #{BusinessTimeMultical::VERSION}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
