class WelcomeController < ApplicationController

	def index
		@user = User.new
		@users = User.paginate(page: params[:page])
		if logged_in?
			@micropost  = current_user.microposts.build
			@feed_items = current_user.feed.paginate(page: params[:page])
		end
	end

end
