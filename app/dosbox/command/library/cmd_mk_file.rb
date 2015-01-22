module DOSBox
  module Command
    module Library
			include BaseCommand

      class CmdMkFile

        def initialize(command_name, drive)
          init(command_name, drive)
        end

        def execute(outputter)
          file_name = @params[0]
          file_content = @params[1]
          file_item = FileItem.new(file_name, file_content)
          @drive.current_dir.add(file_item)
        end
      end
    end
  end
end
