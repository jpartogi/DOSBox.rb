module CommandHelper
  def prepare_for_commands
    @drive = Drive.new("C")
    @root_dir = @drive.root_dir
    @invoker = Invoker.new

    @outputter = MockOutputter.new

    @num_of_files_before_test = @root_dir.num_of_contained_files
    @num_of_dirs_before_test = @root_dir.num_of_contained_dirs
  end

  def execute_command(command)
    @invoker.execute_command(command, @outputter)
  end
end