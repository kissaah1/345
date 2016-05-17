class GroupsController < ApplicationController
	before_action :logged_in_user, only: [:create, :show, :edit, :update, :destroy]
	before_action :correct_user, only: [:edit, :update, :destroy]

	def create
		@group = current_user.groups.build(group_params)
		if @group.save
			flash[:success] = "Posted!"
			redirect_to current_user
		else
			render 'new'
		end
	end

	def new
		@group = Group.new
	end

	def show
		@groups = @user.groups
	end

	def edit
		@group = Group.find(params[:id])
	end

	def update
		@group = Group.find(params[:id])
		if @group.update_attributes(group_params)
			# Handle a successful update.
			flash[:success] = "Group has been updated"
			redirect_to current_user
		else
			render 'edit'
		end
	end
	
	def destroy
		@group.destroy
		flash[:success] = "Group deleted"
		redirect_to request.referrer || users_path(@user)
	end

	private

		def group_params
			params.require(:group).permit(:name, :description)
		end

		def correct_user
			@group = current_user.groups.find_by(id: params[:id])
			redirect_to root_url if @group.nil?
		end

end
