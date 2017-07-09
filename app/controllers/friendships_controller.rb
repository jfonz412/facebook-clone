class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_for_existing_friendships, only: :create # neccessary anymore?

  def create
  	@friendship = current_user.friendships.build(friend_id: params[:friend_id])
  	if @friendship.save
  		flash[:success] = "Friend request sent"
  		redirect_to current_user
  	else
      flash[:danger] = "Something went wrong..."
  		redirect_to users_path
  	end
  end

  def update
    @friendship = Friendship.find(params[:id])
    @friendship.update_attributes(accepted: true)
    flash[:success] = "Request Accepted!"
    redirect_to current_user
  end

  def destroy
    @friendship = Friendship.find(params[:id]) # SECURITY ISSUE, NEED FIXING
    @friendship.destroy
  	flash[:success] = "Friend removed"
  	redirect_to current_user
  end

  private
    def check_for_existing_friendships
      friendship = current_user.friendships.build(friend_id: params[:friend_id])
      existing_friendship = Friendship.where(user_id: friendship.user_id, friend_id: friendship.friend_id)
      existing_friendship = Friendship.where(user_id: friendship.friend_id, friend_id: friendship.user_id)
      if existing_friendship[0] != nil
        flash[:danger] = "Friendship already exists!"
        redirect_to users_path
      end
    end
end
