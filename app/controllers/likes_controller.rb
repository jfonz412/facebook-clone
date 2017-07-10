class LikesController < ApplicationController
  def create
  	@like = current_user.likes.build(post_id: params[:post_id])
  	@like.save
  	redirect_back(fallback_location: root_path)
  end

  def destroy
  end
end
