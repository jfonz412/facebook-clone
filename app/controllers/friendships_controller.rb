class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  def create
  	@friendship = current_user.friendships.build(friend_id: params[:friend_id])
  	if @friendship.save
  		redirect_to root_url
  	else
  		render users_path
  	end
  end

  def destroy
  	@friendship = current_user.friendships.find_by_friend_id(params[:friend_id]).destroy
  	redirect_to current_user
  end
end
