module DOSBox
	module Command
		class Invoker
      attr_writer :commands

      def initialize
        @commands = Array.new
      end

      def add_command(command)
        @commands << command
      end

      def execute_command(command, outputter)
        command_name = self.parse_command_name(command)
        command_params = self.parse_command_params(command)

        begin
          @commands.each do |command|
            if command.command_name.eql? command_name
              command.params= command_params

              unless command.check_params(outputter)
                outputter.println("Wrong parameter entered.")
                return
              end

              command.execute(outputter)
              return
            end
          end
        rescue => e
          outputter.println(e.message)
        end
      end

      def parse_command_name(command)
        command = command.downcase.strip
        command = command.gsub(/[,;]/, "\s") # Replace comma and semicolon with whitespace

        cmd = command
        for i in 0..command.length
          if command[i].eql? ' '
            cmd = command[0..i]
            break
          end
        end

        cmd.strip
      end

      def parse_command_params(command)
        params = Array.new

        command = command.downcase.strip
        command = command.gsub(/[,;]/, "\s") # Replace comma and semicolon with whitespace

        last_space = 0
        for i in 0..command.length
          if command[i].eql? ' ' or i+1 == command.length
            params << command[last_space..i].strip
            last_space = i
          end
        end

        unless params.empty?
          params.delete_at(0)

          params.each do |param|
            params.delete(param) if param.empty?
          end
        end

        params
      end
		end
	end
end