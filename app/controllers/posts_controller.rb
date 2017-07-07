class PostsController < ApplicationController
  before_action :authenticate_user!

  def create
  	@post = current_user.posts.build(post_params)
  	if @post.save
  		flash[:success] = "Post created!"
  		redirect_to root_url #should keep user on either home or profile, wherever submitted
  	else
  		flash[:danger] = "#{@post.errors.full_messages}"
  		redirect_to root_url
  	end
  end

  private
  	def post_params
		params.require(:post).permit(:content)
  	end
end
