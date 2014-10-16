require 'spec_helper'
require 'command_helper'

describe CmdDir do
  include CommandHelper

  before :each do
    prepare_for_commands

    @subdir1 = Directory.new("subdir1")
    @root_dir.add(@subdir1)

    @file1 = FileItem.new("file1.txt", "content")
    @root_dir.add(@file1)

    @cmd = CmdDir.new("dir", @drive)
    @invoker.add_command(@cmd)
  end

  it "should print current directory content when no parameter is given" do
    @drive.change_current_dir(@root_dir)

    execute_command("dir")

    expect(@outputter.output).to include @root_dir.path
  end

  it "should print file name inside directory when no parameter is given" do
    @drive.change_current_dir(@root_dir)

    execute_command("dir")

    expect(@outputter.output).to include @file1.name
  end

  it "should print sub-directories when no parameter is given" do
    @drive.change_current_dir(@root_dir)

    execute_command("dir")

    expect(@outputter.output).to include @subdir1.name
  end

  it "should print footer when no parameter is given" do
    @drive.change_current_dir(@root_dir)

    execute_command("dir")

    expect(@outputter.output).to include "1 File(s)"
    expect(@outputter.output).to include "1 Dir(s)"
  end

  it "should print directory when absolute path is given as param" do
    @drive.change_current_dir(@root_dir)

    execute_command("dir c:\\subdir1")

    expect(@outputter.output).to include @subdir1.path
  end

  it "should print footer when absolute path is given as param" do
    @drive.change_current_dir(@root_dir)

    execute_command("dir c:\\subdir1")

    expect(@outputter.output).to include "0 File(s)"
    expect(@outputter.output).to include "0 Dir(s)"
  end

  it "should print current path when file is given as param" do
    @drive.change_current_dir(@root_dir)

    execute_command("dir " + @file1.path)

    expect(@outputter.output).to include @root_dir.path
  end

  it "should print file in given path when file is given as param" do
    @drive.change_current_dir(@root_dir)

    execute_command("dir " + @file1.path)

    expect(@outputter.output).to include @file1.name
  end

  it "should print footer when file is given as param" do
    @drive.change_current_dir(@root_dir)

    execute_command("dir " + @file1.path)

    expect(@outputter.output).to include "1 File(s)"
    expect(@outputter.output).to include "1 Dir(s)"
  end

  it "should print error when given a non-existing directory as param" do
    @drive.change_current_dir(@root_dir)

    execute_command("dir c:\\bar")

    expect(@outputter.output).to include CmdDir::SYSTEM_CANNOT_FIND_THE_PATH_SPECIFIED
  end

  it "should reset all params" do
    @drive.change_current_dir(@root_dir)

    execute_command("dir c:\\subdir1")

    expect(@outputter.output).to include @subdir1.path

    execute_command("dir")

    expect(@outputter.output).to include @root_dir.path
  end
end