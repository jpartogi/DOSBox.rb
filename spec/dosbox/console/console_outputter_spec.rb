require 'spec_helper'

describe ConsoleOutputter do
  it "should print with new lines" do
    outputter = MockOutputter.new
    outputter.println("hello")

    expect(outputter.has_characters_printed).to be_true
  end

  it "should print with no lines" do
    outputter = MockOutputter.new
    outputter.printnl("hello")

    expect(outputter.has_characters_printed).to be_true
  end

  it "should reset stats" do
    outputter = MockOutputter.new
    outputter.printnl("hello")
    outputter.reset_stats

    expect(outputter.has_characters_printed).to be_false
  end
end