module DOSBox
	module Console
		class ConsoleProc
      # :nocov:
			def initialize(invoker, drive, outputter)
				@invoker = invoker
				@drive = drive
				@outputter = outputter
			end
      # :nocov:

      # :nocov:
			def process_input
				@outputter.println "DOSBox, Scrum.org, Professional Scrum Developer Training"
				@outputter.println "Copyright (c) Joshua Partogi. All rights reserved."

				lines = ""

				while lines != "exit"
					@outputter.newline
					@outputter.printnl @drive.prompt
					
					begin
						chars = gets
						lines = chars.strip
					rescue
						# Do nothing
          end

          @outputter.reset_stats
          @invoker.execute_command(lines, @outputter)
				end

				@outputter.println "Goodbye!"
      end
      # :nocov:
		end
	end
end