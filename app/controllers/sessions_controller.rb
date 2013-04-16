class SessionsController < ApplicationController
  def new
  end

  def create
    # Retrieve the user that is trying to log in.
    user = User.find_by_email(params[:session][:email].downcase)
    # If there is such a user (with that email), & the password authenticates...
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or user
    else
      flash.now[:error] = 'Invalid email/password combination' # Not quite right!
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
