require 'spec_helper'

describe Invoker do
  before :each do
    @invoker = Invoker.new

    @cmd = CmdMock.new("dir", @drive)
    @invoker.add_command(@cmd)

    @outputter = MockOutputter.new
  end

  describe "Command Parser" do
    it "should parse command name" do
      command = "mkdir dir_name"
      expect(@invoker.parse_command_name(command)).to eq('mkdir')

      command = "MKDIR dir name"
      expect(@invoker.parse_command_name(command)).to eq('mkdir')
    end

    it "should parse command name ended by whitespaces" do
      command = "dir    "
      expect(@invoker.parse_command_name(command)).to eq('dir')
    end

    it "should parse command name ended by comma" do
      command = "mkdir, dir_name"
      expect(@invoker.parse_command_name(command)).to eq('mkdir')
    end

    it "should parse command parameters" do
      command = "mkdir dir1 dir2 dir3"
      expect(@invoker.parse_command_params(command)).to eq(%w(dir1 dir2 dir3))
    end

    it "should parse command parameters separated by comma" do
      command = "mkdir dir1, dir2, dir3"
      expect(@invoker.parse_command_params(command)).to eq(%w(dir1 dir2 dir3))

      command = "mkdir dir1,dir2,dir3"
      expect(@invoker.parse_command_params(command)).to eq(%w(dir1 dir2 dir3))
    end

    it "should parse command parameters separated by many whitespaces" do
      command = "mkdir dir1    dir2    dir3"
      expect(@invoker.parse_command_params(command)).to eq(%w(dir1 dir2 dir3))
    end
  end

  describe "Command Executor" do
    it "should execute command" do
      @invoker.execute_command("dir", @outputter)
      expect(@cmd.to_s).to eq("dir")
      expect(@cmd.executed).to be_true
    end

    it "should execute command with leading and ending spaces" do
      @invoker.execute_command("   dir", @outputter)
      expect(@cmd.executed).to be_true

      @invoker.execute_command("dir   ", @outputter)
      expect(@cmd.executed).to be_true
    end

    it "should execute command with parameters" do
      @invoker.execute_command("dir param1 param2", @outputter)
      expect(@cmd.executed).to be_true
    end

    it "should not execute command with invalid syntax" do
      @cmd.num_of_params_ret_value= false
      @invoker.execute_command("dir blah", @outputter)
      expect(@cmd.executed).to be false
    end

    it "should not execute command with wrong number of params" do
      @cmd.param_values_ret_value= false
      @invoker.execute_command("dir blah", @outputter)
      expect(@cmd.executed).to be false
    end
  end
end