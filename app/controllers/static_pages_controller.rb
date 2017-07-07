class StaticPagesController < ApplicationController
	def home 
		@post = Post.new
	end

	def about
	end

	def contact
	end
end
