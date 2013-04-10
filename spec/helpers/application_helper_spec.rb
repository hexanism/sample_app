require 'spec_helper'

describe ApplicationHelper do
  describe "full title" do
    # A full title created from the page title 'foo' should match /foo/
    it "should include the page title" do
      full_title("foo").should =~ /foo/
    end

    # Every title should include the base title.
    it "should include the base title" do
      full_title("foo").should =~ /^Ruby on Rails Tutorial Sample App/
    end

    # If no page title is given there shouldn't be a bar.
    it "should not include a bar for the home page" do
      full_title("").should_not =~ /\|/
    end
  end
end