class LikesController < ApplicationController
  before_action :authenticate_user!
  def create
  	@like = current_user.likes.build(post_id: params[:post_id])
  	@like.save
    send_notice
  	redirect_back(fallback_location: root_path) # need to figure out how to render
  	# can rescue if this fails
  end

  def destroy
  	@like = current_user.likes.where("post_id = ?", params[:post_id])
  	Like.destroy(@like[0].id)
  	redirect_back(fallback_location: root_path)
  end

  private
    def send_notice
      post = Post.find(params[:post_id])
      user = post.user
      notice = user.notices.build(other_user_id: current_user.id,
                                  notice_type: "Like", type_id: @like.id)
      notice.save
    end
end
