$LOAD_PATH.unshift("#{File.dirname(__FILE__)}/app")

require 'dosbox'

configurator = Configurator.new
configurator.configurate_system