require 'spec_helper'
require 'command_helper'

describe CmdCd do
  include CommandHelper

  before :each do
    prepare_for_commands

    @subdir1 = Directory.new("subdir1")
    @root_dir.add(@subdir1)

    @cmd = CmdCd.new("cd", @drive)
    @invoker.add_command(@cmd)
  end

  it "should change to sub-directory with absolute path" do
    @drive.change_current_dir(@root_dir)

    execute_command("cd " + @subdir1.path)

    expect(@outputter.output).to be_empty
    expect(@drive.current_dir).to be @subdir1
  end

  it "should change to sub-directory with relative path" do
    @drive.change_current_dir(@root_dir)

    execute_command("cd " + @subdir1.name)

    expect(@outputter.output).to be_empty
    expect(@drive.current_dir).to be @subdir1
  end

  it "should not change directory when directory is not found" do
    @drive.change_current_dir(@root_dir)

    execute_command("cd subdir2")

    expect(@outputter.output).to include CmdCd::SYSTEM_CANNOT_FIND_THE_PATH_SPECIFIED
  end

  it "should change to sub-directory ending with backslash" do
    @drive.change_current_dir(@root_dir)

    execute_command("cd " + @subdir1.path + "\\")

    expect(@outputter.output).to be_empty
    expect(@drive.current_dir).to be @subdir1
  end

  it "should change to root directory when backslash is given" do
    @drive.change_current_dir(@subdir1)

    execute_command("cd \\")

    expect(@outputter.output).to be_empty
    expect(@drive.current_dir).to be @root_dir
  end

  it "should change to root directory when double dot is given" do
    @drive.change_current_dir(@subdir1)

    execute_command("cd ..")

    expect(@outputter.output).to be_empty
    expect(@drive.current_dir).to be @root_dir
  end

  it "should remain in root directory when double dot is given and already in root directory" do
    @drive.change_current_dir(@root_dir)

    execute_command("cd ..")

    expect(@outputter.output).to be_empty
    expect(@drive.current_dir).to be @root_dir
  end

  it "should remain in current directory when dot is given" do
    @drive.change_current_dir(@subdir1)

    execute_command("cd .")

    expect(@outputter.output).to be_empty
    expect(@drive.current_dir).to be @subdir1
  end

  it "should print current directory when no parameter is given" do
    @drive.change_current_dir(@subdir1)

    execute_command("cd")

    expect(@outputter.output).to eq(@subdir1.path)
  end

  it "should not change directory when parameter given is a file" do
    @file1 = FileItem.new("file1.txt", "content")
    @root_dir.add(@file1)

    @drive.change_current_dir(@root_dir)

    execute_command("cd " + @file1.path)

    expect(@outputter.output).to include CmdCd::DESTINATION_IS_FILE
    expect(@drive.current_dir).to be @root_dir
  end

  it "should remain in current directory when invalid absolute path is given" do
    @drive.change_current_dir(@subdir1)

    execute_command("cd c:\\gaga\\gugus")

    expect(@outputter.output).to include CmdCd::SYSTEM_CANNOT_FIND_THE_PATH_SPECIFIED
    expect(@drive.current_dir).to be @subdir1
  end

  it "should remain in current directory when invalid relative path is given" do
    @drive.change_current_dir(@subdir1)

    execute_command("cd subsubdir")

    expect(@outputter.output).to include CmdCd::SYSTEM_CANNOT_FIND_THE_PATH_SPECIFIED
    expect(@drive.current_dir).to be @subdir1
  end

  it "should reset all parameters" do
    @drive.change_current_dir(@root_dir)

    execute_command("cd " + @subdir1.path)

    expect(@outputter.output).to be_empty
    expect(@drive.current_dir).to be @subdir1

    execute_command("cd")
    expect(@outputter.output).to eq(@subdir1.path)
  end
end