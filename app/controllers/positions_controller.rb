class PositionsController < ApplicationController
	before_action :logged_in_user, only: [:create, :edit, :update, :destroy]
	before_action :correct_user, only: [:update, :destroy]

	def create
		@position = current_user.positions.build(position_params)
		if @position.save
			flash[:success] = "Posted!"
			redirect_to current_user
		else
			render 'users/show'
		end
	end

	def edit
		@position = Position.find(params[:id])
	end

	def update
		@position = Position.find(params[:id])
		if @position.update_attributes(position_params)
			# Handle a successful update.
			flash[:success] = "Position has been updated"
			redirect_to current_user
		else
			render 'edit'
		end
	end
	
	def destroy
		@position.destroy
		flash[:success] = "Position deleted"
		redirect_to request.referrer || users_path(@user)
	end

	private

		def position_params
			params.require(:position).permit(:title, :company, :summary, :start_date, :end_date, :is_current)
		end

		def correct_user
			@position = current_user.positions.find_by(id: params[:id])
			redirect_to root_url if @position.nil?
		end

end
