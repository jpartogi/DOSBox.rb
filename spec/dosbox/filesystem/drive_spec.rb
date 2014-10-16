require 'spec_helper'

describe Drive do
  before :all do
    @drive = Drive.new("C")
    @root_dir = @drive.root_dir

    @sub_dir1 = Directory.new("subdir1")
    @root_dir.add(@sub_dir1)

    @sub_sub_dir1 = Directory.new("subsubdir1")
    @sub_dir1.add(@sub_sub_dir1)

    @sub_sub_dir2 = Directory.new("subsubdir2")
    @sub_dir1.add(@sub_sub_dir2)
  end

  it "should change directory when relative path is given" do
    @drive.change_current_dir(@root_dir)
    expect(@drive.item_from_path("subdir1")).to eq(@sub_dir1)
  end

  it "should change directory when absolute path is given" do
    @drive.change_current_dir(@root_dir)
    expect(@drive.item_from_path(@sub_dir1.path)).to eq(@sub_dir1)
  end

  it "should return the correct path when double forward slash is given" do
    path = '\\'
    @drive.change_current_dir(@root_dir)
    expect(@drive.item_from_path(path)).to eq(@root_dir)

    path = '\\subdir1'
    @drive.change_current_dir(@sub_dir1)
    expect(@drive.item_from_path(path)).to eq(@sub_dir1)
  end

  it "should return the correct path when dot is given" do
    path = '.'
    @drive.change_current_dir(@sub_dir1)
    expect(@drive.item_from_path(path)).to eq(@sub_dir1)

    path = '.\\'
    @drive.change_current_dir(@sub_dir1)
    expect(@drive.item_from_path(path)).to eq(@sub_dir1)

    path = '.\\subdir1'
    @drive.change_current_dir(@root_dir)
    expect(@drive.item_from_path(path)).to eq(@sub_dir1)
  end

  it "should return the correct path when double dot is given" do
    path = '..'
    @drive.change_current_dir(@sub_dir1)
    expect(@drive.item_from_path(path)).to eq(@root_dir)

    path = '..\\'
    @drive.change_current_dir(@sub_dir1)
    expect(@drive.item_from_path(path)).to eq(@root_dir)

    path = '..\\subsubdir2'
    @drive.change_current_dir(@sub_sub_dir1)
    expect(@drive.item_from_path(path)).to eq(@sub_sub_dir2)
  end
end