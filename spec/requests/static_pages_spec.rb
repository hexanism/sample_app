require 'spec_helper'

# When the tests are run, all the content as strings will be
# the human-readable output for each test...
# For example:
# "Static pages Home page should have the content 'Sample App'"

# Describe block for tests pertaining to static pages.
describe "Static pages" do

  let(:base_title) { "Ruby on Rails Tutorial Sample App" }

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

    it "should have the base title" do
      visit '/static_pages/home'
      page.should have_selector('title', 
          :text => base_title)
    end

    it "should not have a custom title" do
      visit '/static_pages/home'
      page.should_not have_selector('title', :text => '| Home')
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
          :text => "#{base_title} | Help")
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
          :text => "#{base_title} | About Us")
    end
  end

  describe "Contact page" do
    it "should have the title 'Contact'" do
      visit '/static_pages/contact'
      page.should have_selector('title',
          :text => "#{base_title} | Contact")
    end

    it "should have the content 'Contact'" do
      visit '/static_pages/contact'
      page.should have_selector('h1', :text => 'Contact')
    end
  end
end