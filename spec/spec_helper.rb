require 'simplecov'

SimpleCov.start do
  add_filter "/spec/"
  add_filter "/vendor/"
  add_group "Commands", "app/dosbox/command/library"
end

require File.expand_path("../../app/dosbox", __FILE__)