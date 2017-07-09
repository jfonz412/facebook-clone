class StaticPagesController < ApplicationController
	def home 
		if user_signed_in?
			@post = Post.new
			@user_feed = current_user.feed
		end
	end

	def about
	end

	def contact
	end
end
