class UsersController < ApplicationController

	def index
		@users = User.all
	end

	def new
		@user = User.new
	end

	def create
		user = User.new(user_params)
		if user.save
			session[:user_id] = user.id
			redirect_to user_path(user.id)
		else
			redirect_to :back
		end
	end

	def show
		@user = User.find(params[:id])
	end

	def edit
		@user = User.find(params[:id])
		if @user.id != session[:user_id]
      redirect_to @user
		end
	end

	def update
    @user = User.find(session[:user_id])
		@user.update_attributes(user_params)
		redirect_to @user
	end

	def destroy
		User.delete(session[:user_id])
		redirect_to root
	end

	private

	def user_params
		params.require(:user).permit(:username, :email, :password, :password_confirmation)
	end

end
