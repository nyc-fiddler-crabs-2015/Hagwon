class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  def current_user
    User.find(session[:user_id])
  end

  def current_user_path
    user_path(session[:user_id])
  end

end
