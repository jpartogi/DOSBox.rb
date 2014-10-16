module DOSBox
  module Command
    module Library
      class CmdDir < BaseCommand
        attr_reader :directory_to_print

        SYSTEM_CANNOT_FIND_THE_PATH_SPECIFIED = "File Not Found."

        def initialize(command_name, drive)
          super(command_name, drive)
        end

        def check_number_of_params(num_of_params)
          num_of_params.eql? 0 or num_of_params.eql? 1
        end

        def check_param_values(outputter)
          if @params.length.eql? 0
            @directory_to_print = @drive.current_dir
          else
            @directory_to_print = self.check_and_prepare_path_parameter(@params[0], outputter)
          end

          (not @directory_to_print.nil?)
        end

        def check_and_prepare_path_parameter(path_name, outputter)
          file_system_item = @drive.item_from_path(path_name)

          if file_system_item.nil?
            outputter.println(SYSTEM_CANNOT_FIND_THE_PATH_SPECIFIED)
            return nil
          end

          unless file_system_item.is_directory?
            return file_system_item.parent
          end

          return file_system_item
        end

        def execute(outputter)
          self.print_header(@directory_to_print, outputter)
          self.print_content(@directory_to_print.content, outputter)
          self.print_footer(@directory_to_print, outputter)
        end

        def print_header(dir_to_print, outputter)
          outputter.println("Directory of " + dir_to_print.path)
          outputter.newline
        end

        def print_content(dir_content, outputter)
          dir_content.each do |item|
            if item.is_directory?
              outputter.printnl("<DIR>")
            else
              outputter.printnl(item.content.length.to_s)
            end

            outputter.printnl("\t" + item.name)
            outputter.newline
          end
        end

        def print_footer(dir_to_print, outputter)
          outputter.println("\t" + dir_to_print.num_of_contained_files.to_s + " File(s)")
          outputter.println("\t" + dir_to_print.num_of_contained_dirs.to_s + " Dir(s)")
        end
      end
    end
  end
end
