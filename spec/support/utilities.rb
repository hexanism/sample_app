include ApplicationHelper

# This function allows us to sign in as a valid user
# using a single line of code.
def valid_signin(user)
  fill_in "Email", with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
end

# Matchers allow us to simlify tests such as checking for errors.
# With this definition here we can call have_error_message('Invalid')
# instead of the whole line below.
RSpec::Matchers.define :have_error_message do |msg|
  match do |page|
    page.should have_selector('div.alert.alert-error', text: msg)
  end
end