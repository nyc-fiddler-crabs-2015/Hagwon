class WelcomeController < ApplicationController

  def index
    if session[:user_id]
      redirect_to user_path(session[:user_id])
    else
      render text: "I am the welcome page that presents our website"
    end
  end

end