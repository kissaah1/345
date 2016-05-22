class UsersController < ApplicationController
	before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy, :following, :followers]
	before_action :correct_user, only: [:edit, :update]
	before_action :admin_user, only: [:destroy]

	def index
		@users = User.search(params[:query]).page(params[:page]).per_page(10)
#		@users = User.paginate(page: params[:page], :per_page => 10)
	end

	def admins
		@admins = User.where('users.admin = ?', true).page(params[:page]).per_page(10)
	end
	def enthusiasts
		@enthusiasts = User.where('users.enthusiast = ?', true).page(params[:page]).per_page(10)
	end
	def skeptics
		@skeptics = User.where('users.skeptic = ?', true).page(params[:page]).per_page(10)
	end
	def pioneers
		@pioneers = User.where('users.pioneer = ?', true).page(params[:page]).per_page(10)
	end
	def navigators
		@navigators = User.where('users.navigator = ?', true).page(params[:page]).per_page(10)
	end
	def coachs
		@coachs = User.where('users.coach = ?', true).page(params[:page]).per_page(10)
	end
	def solos
		@solos = User.where('users.solo = ?', true).page(params[:page]).per_page(10)
	end

	def show
		@user = User.find(params[:id])
		@microposts = @user.microposts.paginate(page: params[:page], :per_page => 3, :total_entries => 30)
		@surveys = @user.microposts
		@positions = @user.positions.paginate(page: params[:page], :per_page => 3)
		@companies = @user.companies.paginate(page: params[:page], :per_page => 3)
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
 			@user.send_activation_email
 			flash[:info] = "Please check your email to activate your account."
 			redirect_to root_url
		else
			render 'new'
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def setting
		@user = User.find(params[:id])
	end

	def summary
		@user = User.find(params[:id])
	end

	def skills
		@user = User.find(params[:id])
	end

	def allies
		@user = User.find(params[:id])
	end

	def avatar
		@user = User.find(params[:id])
	end


	def update
		@user = User.find(params[:id])
		if @user.update_attributes(user_params)
			# Handle a successful update.
			flash[:success] = "Profile updated"
			redirect_to @user
		else
			render 'edit'
		end
	end

	def destroy
		User.find(params[:id]).destroy
		flash[:success] = "User deleted"
		redirect_to users_url
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
			params.require(:user).permit(:name, :email, :password, :password_confirmation, 
				:location, :headline, :industry, :linkedin, :summary, :skills, :other_skills,
				:enthusiast, :skeptic, :navigator, :pioneer, :coach, :solo)
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
			redirect_to current_user unless current_user.admin?
		end

end
