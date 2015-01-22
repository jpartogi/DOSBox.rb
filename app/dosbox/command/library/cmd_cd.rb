module DOSBox
	module Command
		include BaseCommand

		module Library
			class CmdCd
        SYSTEM_CANNOT_FIND_THE_PATH_SPECIFIED = "The system cannot find the path specified."
        DESTINATION_IS_FILE = "The directory name is invalid."

				def initialize(command_name, drive)
					init(command_name, drive)
        end

        def check_number_of_params(num_of_params)
          num_of_params.eql? 0 or num_of_params.eql? 1
        end

        def check_param_values(outputter)
          if @params.length > 0
            @destination_directory = self.extract_and_check_if_valid_directory(@params[0], outputter)
            not @destination_directory.nil?
          else
            @destination_directory = nil
            true
          end
        end

        def execute(outputter)
          if @params.length.eql? 0
            self.print_current_directory_path(outputter)
          else
            self.change_current_directory(@destination_directory, outputter)
          end
        end

        def change_current_directory(destination_directory, outputter)
          unless @drive.change_current_dir(destination_directory)
            outputter.println(SYSTEM_CANNOT_FIND_THE_PATH_SPECIFIED)
          end
        end

        def print_current_directory_path(outputter)
          outputter.println(@drive.current_dir.path)
        end

        def extract_and_check_if_valid_directory(destination_directory_name, outputter)
          @destination_directory = @drive.item_from_path(destination_directory_name)

          if @destination_directory.nil?
            outputter.println(SYSTEM_CANNOT_FIND_THE_PATH_SPECIFIED)
            return nil
          end

          unless @destination_directory.is_directory?
            outputter.println(DESTINATION_IS_FILE)
            return nil
          end

          @destination_directory
        end
			end
		end
	end
end