module DOSBox
	module Command
		class BaseCommand
      attr_reader :drive, :params, :command_name

      INCORRECT_SYNTAX = "The syntax of the command is incorrect."
      DEFAULT_ERROR_MESSAGE_WRONG_PARAMETER = "Wrong parameter entered."

			def initialize(command_name, drive)
        @command_name = command_name.downcase
        @drive = drive
        @params = Array.new
      end

      # Stub - will be overridden
      def execute(outputter); end

      def check_params(outputter)
        unless check_number_of_params(@params.length)
          outputter.println(INCORRECT_SYNTAX)
          return false
        end

        unless check_param_values(outputter)
          unless outputter.has_characters_printed
            outputter.println(DEFAULT_ERROR_MESSAGE_WRONG_PARAMETER)
          end
          return false
        end

        true
      end

      def compare_command_name(command_name)
        @command_name.eql? command_name
      end

      def params=(params)
        @params.clear
        @params = params
      end

      def to_s
        @command_name
      end

      protected
        # Stub - will be overridden
        def check_number_of_params(num_of_params); true end

        # Stub - will be overridden
        def check_param_values(outputter); true end
		end
	end
end