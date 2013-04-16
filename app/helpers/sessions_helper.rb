module SessionsHelper
  def sign_in(user)
    # Cookies variable provided by Rails:
    # a hash where each member has a 'value:'
    # and an optional 'expires:'
    #
    # Here: cookies[:remember_token] = { value: user.remember_token }
    # The .permanent function sets expires: 20.years.from_now
    #
    # The current user can be found by
    # User.find_by_remember_token(cookies[:remember_token])
    cookies.permanent[:remember_token] = user.remember_token
    self.current_user = user
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  # If the current_user is nil returns false,
  # otherwise true.
  def signed_in?
    !current_user.nil?
  end

  # Why don't we just assign @current_user = user above?
  def current_user=(user)
    @current_user = user
  end

  # @current_user is lost every time the user navigates
  # to a new page. When this is the case we need to look
  # up the current user based on the remember token cookie.
  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end

  def current_user?(user)
    user == current_user
  end

  # If there is a location stored (via store_location)
  # then we redirect there and delete the value.
  # Otherwise we just redirect to the default.
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url
  end
end
