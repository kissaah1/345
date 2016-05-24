class EmploymentsController < ApplicationController
	before_action :logged_in_user, only: [:index, :create, :edit, :update, :destroy]

	def index
	end

	def new
		@employment = Employment.new
	end

	def create
		@employment = current_user.employments.build(employment_params)
		if @employment.save
			flash[:info] = "Welcome aboard!"
			redirect_to current_user
		end
	end

	def edit
		@employment = Employment.find(params[:id])
	end

	def update
		@employment = Employment.find(params[:id])
		if @employment.update_attributes(employment_params)
			flash[:info] = "Role has been updated."
			redirect_to current_user
		else
			render 'edit'
		end
	end


	private

	def employment_params
		params.require(:employment).permit(:secior, :manager, :staff)
	end

	def correct_user
		@employment = current_user.employments.find_by(id: params[:id])
		redirect_to root_url if @employment.nil?
	end


end
