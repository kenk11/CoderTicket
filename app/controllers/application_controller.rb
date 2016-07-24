class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :signed_in?, :require_login
  before_action :require_login

  def current_user
    @current_user ||= User.find_by_id session[:user_id]
  end

  def signed_in?
    !!current_user
  end

  def require_login
    unless signed_in?
      flash[:error] = 'You must be logged in to access!'
      redirect_to new_session_path
    end
  end
end
