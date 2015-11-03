require 'simplecov'
require "codeclimate-test-reporter"

SimpleCov.start do
  add_filter "/spec/"
  add_filter "/vendor/"
  add_group "Commands", "app/dosbox/command/library"
end

CodeClimate::TestReporter.start

require File.expand_path("../../app/dosbox", __FILE__)