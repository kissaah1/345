class WelcomeController < ApplicationController

	def index
		@user = User.new
		@users = User.paginate(page: params[:page])
		if logged_in?
			@micropost  = current_user.microposts.build
			@feed_items = current_user.feed.paginate(page: params[:page])
		end
	end

	def show
		@user = User.find(params[:id])
		@microposts = @user.microposts.paginate(page: params[:page], :per_page => 3, :total_entries => 30)
	end


  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end


	private

		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end

# Confirms a logged-in user.
	def logged_in_user
		unless logged_in?
			store_location
			flash[:danger] = "Please log in."
			redirect_to login_url
		end
	end

	# Confirms the correct user.
	def correct_user
		@user = User.find(params[:id])
		redirect_to(root_url) unless @user == current_user
	end

	# Confirms an admin user.
	def admin_user
		redirect_to(root_url) unless current_user.admin?
	end

end
