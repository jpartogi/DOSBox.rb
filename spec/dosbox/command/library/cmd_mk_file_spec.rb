require 'spec_helper'
require 'command_helper'

describe CmdMkFile do
  include CommandHelper

  before :each do
    prepare_for_commands

    @subdir1 = Directory.new("subdir1")
    @root_dir.add(@subdir1)

    @cmd = CmdMkFile.new("mkfile", @drive)
    @invoker.add_command(@cmd)
  end

  it "should create file with content" do
    file_name = "file.txt"
    file_content = "This is the content"

    execute_command("mkfile " + file_name + " " + file_content)

    #expect(@outputter.output).to be_empty
    #expect(@drive.current_dir.num_of_contained_files).to eq 1

    file = @drive.item_from_path(@drive.current_dir.path + "\\" + file_name)
  end
end