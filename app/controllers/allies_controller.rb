class AlliesController < ApplicationController
	before_action :logged_in_user, only: [:index, :create, :edit, :update, :destroy]
	before_action :correct_user, only: [:edit, :update, :destroy]
	#before_action :admin_user, only: [:create, :edit, :update, :destroy]
	before_action :admin_user, only: [:create, :edit, :update, :destroy]


	def index
		@allies = Ally.paginate(page: params[:page], :per_page => 5)
	end

	def create
		@ally = current_user.allies.build(ally_params)
		if @ally.save
			flash[:success] = "Ally Created!"
			redirect_to current_user
		else
			render 'index'
		end
	end

	def show
		@ally = current_user.allies.find(params[:id])
	end

	def edit
		@ally = Ally.find(params[:id])
	end

	def update
		@ally = Ally.find(params[:id])
		if @ally.update_attributes(ally_params)
			flash[:success] = "Ally has been updated"
			redirect_to current_user
		else
			render 'edit'
		end
	end
	
	def destroy
		@ally.destroy
		flash[:success] = "Ally deleted"
		redirect_to request.referrer || users_path(@user)
	end

	private

		def ally_params
			params.require(:ally).permit(:name, :descriptions)
		end

		# Confirms a logged-in user.
		def logged_in_user
			unless logged_in?
				store_location
				flash[:danger] = "Please log in."
				redirect_to login_url
			end
		end

		def correct_user
			@ally = current_user.allies.find_by(id: params[:id])
			redirect_to root_url if @ally.nil?
		end

		# Confirms an admin user.
		def admin_user
			#redirect_to(root_url) unless current_user.cadmin?
			unless current_user.admin?
				store_location
				flash[:danger] = "You don't have previlege to create a company. Please update your role."
				redirect_to current_user
			end
		end

end
