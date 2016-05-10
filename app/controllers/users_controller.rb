class UsersController < ApplicationController

	def show
		@user = User.find(params[:id])
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
			if @user.save
				log_in @user
			# UserMailer.account_activation(@user).deliver_now
			# @user.send_activation_email
			flash[:info] = "Please check your email to activate your account."
			redirect_to @user
		else
			render 'new'
		end
	end

	private

		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end

# Confirms a logged-in user.
#	def logged_in_user
#		unless logged_in?
#			store_location
#			flash[:danger] = "Please log in to do that."
#			redirect_to login_url
#		end
#	end

end
