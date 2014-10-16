require 'spec_helper'

describe Directory do
  before :each do
    @root_dir = Directory.new("root")
    @sub_dir = Directory.new("subdir")
  end

  it "should have the right path" do
    @root_dir.add(@sub_dir)

    expect(@sub_dir.is_directory?).to be_true
    expect(@sub_dir.parent).to eq(@root_dir)
    expect(@sub_dir.path).to eq("root\\subdir")
  end

  it "should have the right number of FileSystemItem" do
    @root_dir.add(@sub_dir)
    file = FileItem.new("file", "")
    @root_dir.add(file)

    expect(@root_dir.num_of_contained_dirs).to eq(1)
    expect(@root_dir.num_of_contained_files).to eq(1)
  end
end