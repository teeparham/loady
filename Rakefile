require 'rubygems'
require 'rake'

require 'bundler'
Bundler::GemHelper.install_tasks

require 'rake/testtask'

task :default => [:test]

Rake::TestTask.new(:test) do |t|
  t.test_files = %w(test/**/*.rb)
  t.verbose = false
end