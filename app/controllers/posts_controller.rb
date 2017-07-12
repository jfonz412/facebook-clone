class PostsController < ApplicationController
  before_action :authenticate_user!

  def create
  	@post = current_user.posts.build(post_params)
  	if @post.save
  		flash[:success] = "Post created!"
  		redirect_back(fallback_location: root_url) 
  	else
  		flash[:danger] = "#{@post.errors.full_messages}" #clean up
      redirect_back(fallback_location: root_url)
  	end
  end

  def destroy
    @post = current_user.posts.where("id = ?", params[:id])
    Post.destroy(@post[0].id)
    redirect_to user_path(current_user)
  end

  private
  	def post_params
		  params.require(:post).permit(:content)
  	end
end
