class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def logged_in?
    if current_user
      true
    else
      redirect_to new_session_url
    end
  end

  def login!(user)
    @current_user = user
    user.ensure_session_token
    user.save
    session[:session_token] = user.session_token
  end

  def logout
    current_user.reset_session_token!
    session[:session_token] = nil
  end


  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])

  end
end
