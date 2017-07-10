class PostsController < ApplicationController
  before_action :authenticate_user!

  def create
  	@post = current_user.posts.build(post_params)
  	if @post.save
  		flash[:success] = "Post created!"
  		redirect_back(fallback_location: root_url) #should keep user on either home or profile, wherever submitted
  	else
  		flash[:danger] = "#{@post.errors.full_messages}"
      redirect_back(fallback_location: root_url)
  	end
  end

  def destroy
    Post.destroy current_user.posts.where("id = ?", params[:id])
    redirect_to user_path(current_user)
  end

  private
  	def post_params
		params.require(:post).permit(:content)
  	end
end
