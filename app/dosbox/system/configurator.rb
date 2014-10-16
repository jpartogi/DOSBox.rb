module DOSBox
	module System
		class Configurator
			def configurate_system
				drive = Drive.new("C")
				drive.restore

				factory = Factory.new(drive)
				invoker = Invoker.new
				invoker.commands= factory.commands

				console = ConsoleProc.new(invoker, drive)
				console.process_input
			end
		end
	end
end