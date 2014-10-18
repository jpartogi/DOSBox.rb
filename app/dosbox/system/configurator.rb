module DOSBox
	module System
		class Configurator
      # :nocov:
			def configurate_system
				drive = Drive.new("C")
				drive.restore

				factory = Factory.new(drive)
				invoker = Invoker.new
				invoker.commands= factory.commands

        outputter = ConsoleOutputter.new
				console = ConsoleProc.new(invoker, drive, outputter)
				console.process_input
      end
      # :nocov:
		end
	end
end