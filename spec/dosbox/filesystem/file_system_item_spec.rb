require 'spec_helper'

describe FileSystemItem do

  it "should check the right name" do
    item = FileSystemItem.new("", nil)

    expect(item.check_name("C:\\")).to be false
    expect(item.check_name("root")).to be true

    expect { FileSystemItem.new("C:,", nil) }.to raise_error
  end

  it "should set path correctly" do
    item = FileSystemItem.new("root", nil)

    expect(item.path).to eq "root"
    expect(item.to_s).to eq "root"
  end

end