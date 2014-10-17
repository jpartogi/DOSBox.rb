require 'spec_helper'

describe FileItem do
  before :all do
    @drive = Drive.new("C")
    @root_dir = @drive.root_dir
  end

  it "should create file successfully" do
    file_name = "file.txt"
    file_content = "content"
    file = FileItem.new(file_name, file_content)

    expect(file.is_directory?).to be_false
    expect(file.name).to eq(file_name)
    expect(file.content).to eq(file_content)
    expect(file.size).to eq(7)
  end

  it "should be in correct directory" do
    file_name = "file.txt"
    file_content = "content"
    file = FileItem.new(file_name, file_content)

    @root_dir.add(file)

    expect(file.parent).to eq(@root_dir)
  end
end