require 'spec_helper'
require 'command_helper'

describe CmdMkDir do
  include CommandHelper

  before :each do
    prepare_for_commands

    @cmd = CmdMkDir.new("mkdir", @drive)
    @invoker.add_command(@cmd)
  end

  it "should create directory to the right location" do
    @drive.change_current_dir(@root_dir)
    test_dir1_name = "test1"

    execute_command("mkdir " + test_dir1_name)

    test_dir1 = @drive.item_from_path(test_dir1_name)

    expect(test_dir1.parent).to eq @root_dir
  end

  it "should print error message when no paremeter is given" do
    @drive.change_current_dir(@root_dir)

    execute_command("mkdir")

    expect(@outputter.output).to include CmdMkDir::INCORRECT_SYNTAX
    expect(@drive.current_dir.num_of_contained_dirs).to eq 0
  end

  it "should print error message when parameter given is incorrect" do
    @drive.change_current_dir(@root_dir)

    execute_command("mkdir c:\\test1")
    expect(@outputter.output).to include CmdMkDir::PARAMETER_CONTAINS_BACKLASH
  end

  it "should not create directories when parameter given is incorrect" do
    @drive.change_current_dir(@root_dir)

    execute_command("mkdir c:\\test1")
    expect(@drive.current_dir.num_of_contained_dirs).to eq 0
  end

  it "should create multiple directories when many parameters are provided" do
    @drive.change_current_dir(@root_dir)
    test_dir1_name = "test1"
    test_dir2_name = "test2"
    test_dir3_name = "test3"

    execute_command("mkdir " + test_dir1_name + " " + test_dir2_name + " " + test_dir3_name)
    expect(@outputter.output).to be_empty

    test_dir1 = @drive.item_from_path(test_dir1_name)
    test_dir2 = @drive.item_from_path(test_dir2_name)
    test_dir3 = @drive.item_from_path(test_dir3_name)

    expect(test_dir1.parent).to eq @root_dir
    expect(test_dir2.parent).to eq @root_dir
    expect(test_dir3.parent).to eq @root_dir
  end

  it "should reset parameters" do
    @drive.change_current_dir(@root_dir)
    test_dir1_name = "test1"

    execute_command("mkdir " + test_dir1_name)

    test_dir1 = @drive.item_from_path(test_dir1_name)

    expect(test_dir1.parent).to eq @root_dir
    expect(@drive.current_dir.num_of_contained_dirs).to eq 1

    execute_command("mkdir")
    expect(@drive.current_dir.num_of_contained_dirs).to eq 1
    expect(@outputter.output).to include CmdMkDir::INCORRECT_SYNTAX
  end

end