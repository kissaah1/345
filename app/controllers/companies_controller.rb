class CompaniesController < ApplicationController
	before_action :logged_in_user, only: [:index, :create, :edit, :update, :destroy]
	before_action :correct_user, only: [:edit, :update, :destroy]
	before_action :cadmin_user, only: [:create, :edit, :update, :destroy]


	def index
		if params[:query].present?
			@companies = Company.search(params[:query]).page(params[:page]).per_page(5)
		else
			@companies = Company.paginate(page: params[:page], :per_page => 5)
		end
	end

	def create
		@company = current_user.companies.build(company_params)
		#@company = Company.new(params[:company])
		#@company.users << current_user
		if @company.save
			flash[:success] = "Company Created!"
			redirect_to current_user
		else
			render 'index'
		end
	end

	def show
		@company = Company.find(params[:id])
	end

	def edit
		@company = Company.find(params[:id])
	end

	def update
		@company = Company.find(params[:id])
		if @company.update_attributes(company_params)
			# Handle a successful update.
			flash[:success] = "Company has been updated"
			redirect_to current_user
		else
			render 'edit'
		end
	end
	
	def destroy
		@company.destroy
		flash[:success] = "company deleted"
		redirect_to request.referrer || users_path(@user)
	end

	private

		def company_params
			params.require(:company).permit(:name, :industry, :website, :summary)
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
			@company = current_user.companies.find_by(id: params[:id])
			redirect_to root_url if @company.nil?
		end

		# Confirms a company admin user.
		def cadmin_user
			#redirect_to(root_url) unless current_user.cadmin?
			unless current_user.cadmin?
				store_location
				flash[:danger] = "You don't have previlege to create a company. Please update your role."
				redirect_to current_user
			end
		end

		# Confirms an admin user.
		def admin_user
			redirect_to(root_url) unless current_user.admin?
		end

end