require 'spec_helper'

describe FileSystemItem do

  it "should check the right name" do
    item = FileSystemItem.new("", nil)

    expect(item.check_name("C:\\")).to be false
    expect(item.check_name("root")).to be true

    expect { FileSystemItem.new("C:,", nil) }.to raise_error
  end

end