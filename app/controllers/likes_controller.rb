class LikesController < ApplicationController
  def create
  	@like = current_user.likes.build(post_id: params[:post_id])
  	@like.save
  	redirect_back(fallback_location: root_path) # need to figure out how to render
  	# can rescue if this fails
  end

  def destroy
  	@like = current_user.likes.where("post_id = ?", params[:post_id])
  	Like.destroy(@like)
  	redirect_back(fallback_location: root_path)
  end
end
