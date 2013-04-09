require 'spec_helper'

# When the tests are run, all the content as strings will be
# the human-readable output for each test...
# For example:
# "Static pages Home page should have the content 'Sample App'"

# Describe block for tests pertaining to static pages.
describe "Static pages" do
  # Describe block for tests of just the home page.
  describe "Home page" do
    # each line beginning with 'it' is an *EXAMPLE*
    # everything within the block executed as a single test.
    it "should have the content 'Sample App'" do
      # Capybara function 'visit' simulates visiting the URI in a browser.
      visit '/static_pages/home'
      # Page variable provided by Capybara.
      page.should have_selector('h1', :text => 'Sample App')
    end

    it "should have the right title" do
      visit '/static_pages/home'
      page.should have_selector('title', 
          :text => "Ruby on Rails Tutorial Sample App | Home")
    end
  end

  # Analagous test for the help page.
  describe "Help page" do
    it "should have the content 'Help'" do
      visit '/static_pages/help'
      page.should have_selector('h1', :text => 'Help')
    end

    it "should have the right title" do
      visit '/static_pages/help'
      page.should have_selector('title',
          :text => "Ruby on Rails Tutorial Sample App | Help")
    end
  end

  describe "About page" do
    it "should have the content 'About Us'" do
      visit '/static_pages/about'
      page.should have_selector('h1', :text => 'About Us')
    end

    it "should have the title 'About Us'" do
      visit '/static_pages/about'
      page.should have_selector('title',
          :text => "Ruby on Rails Tutorial Sample App | About Us")
    end
  end
end