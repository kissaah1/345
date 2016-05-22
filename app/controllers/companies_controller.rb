class CompaniesController < ApplicationController
	before_action :logged_in_user, only: [:index, :create, :edit, :update, :destroy]
	before_action :correct_user, only: [:show, :edit, :update, :destroy]


	def index
		@companies = Company.all
	    @companies = Company.search(params[:search]) if params[:search].present?
		@companies = Company.find_by_name(params[:name])
		@companies = Company.paginate(page: params[:page], :per_page => 5)
	end

	def create
		@company = current_user.companies.build(company_params)
		if @company.save
			flash[:success] = "Company Created!"
			redirect_to current_user
		else
			render 'users/show'
		end
	end

	def show
		@companies = Company.paginate(page: params[:page])
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

		def correct_user
			@company = current_user.companies.find_by(id: params[:id])
			redirect_to root_url if @company.nil?
		end
		# Confirms an admin user.
		def admin_user
			redirect_to(root_url) unless current_user.admin?
		end

end