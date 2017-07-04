class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  def create
  	@friendship = current_user.friendships.build(friend_id: params[:friend_id])
  	if @friendship.save
  		flash[:success] = "Friend request sent"
  		redirect_to current_user
  	else
  		render users_path
  	end
  end

  def destroy
  	@friendship = current_user.friendships.find_by_friend_id(params[:friend_id]).destroy
  	flash[:success] = "Friend removed"
  	redirect_to current_user
  end
end
