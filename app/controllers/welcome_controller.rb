class WelcomeController < ApplicationController

  def index

    redirect_to user_path(current_user.id) if current_user

  end

end