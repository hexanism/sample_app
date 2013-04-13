class ApplicationController < ActionController::Base
  protect_from_forgery
  # This line makes available to controllers the session signin-out functions.
  # By default the helpers are available in the views but not controllers.
  include SessionsHelper

  # Force signout to prevent CSRF attacks.
  # This must be a built-in Rails function.
  # So if some 'unverified request' is made,
  # we make sure whoever was logged in is logged
  # out, and then also whatever the default version
  # of this function does.
  def handle_unverified_request
    sign_out
    super
  end
end
