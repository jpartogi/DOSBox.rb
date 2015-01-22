module DOSBox
  module Command
    module Library
			include BaseCommand

      class CmdMock

        attr_accessor :num_of_params, :num_of_params_ret_value, :param_values_ret_value, :executed

        def initialize(command_name, drive)
          init(command_name, drive)
          @num_of_params_ret_value = true
          @param_values_ret_value = true
          @executed = false
        end

        def check_number_of_params(num_of_params)
          @num_of_params = num_of_params
          @num_of_params_ret_value
        end

        def check_param_values(outputter)
          @param_values_ret_value
        end

        def execute(outputter)
          @executed = true
        end
      end
    end
  end
end