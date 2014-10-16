module DOSBox
  module Command
    module Library

      class CmdMkDir < BaseCommand
        PARAMETER_CONTAINS_BACKLASH = "At least one parameter denotes a path rather than a directory name."

        def initialize(command_name, drive)
          super(command_name, drive)
        end

        def check_number_of_params(num_of_params)
          num_of_params >= 1 ? true : false
        end

        def check_param_values(outputter)
          @params.each do |param|
            return false if parameter_contains_backlashes?(param, outputter)
          end
          true
        end

        def execute(outputter)
          @params.each do |param|
            create_directory(param, @drive)
          end
        end

        private
          def parameter_contains_backlashes?(param, outputter)
            if /[\\\/]/.match(param)
              outputter.println(PARAMETER_CONTAINS_BACKLASH)
              true
            end
            false
          end

          def create_directory(directory_name, drive)
            directory = Directory.new(directory_name)
            drive.current_dir.add(directory)
          end
      end

    end
  end
end
