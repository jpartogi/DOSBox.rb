$LOAD_PATH.unshift("#{File.dirname(__FILE__)}/app")

require 'rubygems' 
require 'rake'
require 'rake/testtask'
require 'bundler/setup'
Bundler.require(:default)

require 'rspec/core/rake_task'
require 'dosbox'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec