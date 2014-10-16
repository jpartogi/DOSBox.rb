$LOAD_PATH.unshift("#{File.dirname(__FILE__)}")

require 'dosbox/console/console_proc'
require 'dosbox/console/console_outputter'
require 'dosbox/console/mock_outputter'
require 'dosbox/command/invoker'
require 'dosbox/command/base_command'
require 'dosbox/command/factory'
require 'dosbox/system/configurator'
require 'dosbox/filesystem/file_system_item'
require 'dosbox/filesystem/directory'
require 'dosbox/filesystem/file_item'
require 'dosbox/filesystem/drive'

# require all commands automatically
Dir[File.dirname(__FILE__) + '/dosbox/command/library/*.rb'].each {|file| require file }

include DOSBox::Console
include DOSBox::System
include DOSBox::FileSystem
include DOSBox::Command
include DOSBox::Command::Library