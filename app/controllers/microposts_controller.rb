class MicropostsController < ApplicationController
	before_action :logged_in_user, only: [:create, :edit, :update, :destroy]
	before_action :correct_user, only: [:edit, :update, :destroy]

	def create
		@micropost = current_user.microposts.build(micropost_params)
		if @micropost.save
			flash[:success] = "Posted!"
			redirect_to current_user
		else
			@feed_items = []
			render 'users/show'
		end
	end

	def edit
		@micropost = Micropost.find(params[:id])
	end

	def update
		@micropost = Micropost.find(params[:id])
		if @micropost.update_attributes(micropost_params)
			# Handle a successful update.
			flash[:success] = "It's updated"
			redirect_to current_user
		else
			render 'edit'
		end
	end

	def destroy
		@micropost.destroy
		flash[:success] = "Micropost deleted"
		redirect_to request.referrer || users_path(@user)
	end

	private

		def micropost_params
			params.require(:micropost).permit(:content, :picture, :survey_1, :survey_2, :survey_3)
		end

		def correct_user
			@micropost = current_user.microposts.find_by(id: params[:id])
			redirect_to root_url if @micropost.nil?
		end

end
