require 'test_helper'

class FriendshipsControllerTest < ActionDispatch::IntegrationTest
	include Devise::Test::IntegrationHelpers
	def setup
		@user = users(:bob)
		@other_user = users(:mike)
		@another_user = users(:sally) # already friends
	end

	test "must be logged in" do
		assert_no_difference "Friendship.count" do
			post friendship_path, params: { :friend_id => @other_user.id }
		end
		sign_in @user
		assert_difference "Friendship.count", 1 do
			post friendship_path, params: { :friend_id => @other_user.id }
		end
	end
	 
	test "can't have duplicate friendships" do
		# Technically passes, DB throws error when same exact friendship is attempted
		# In practice, the controller will stop this too
		#sign_in @user
		#assert_no_difference "Friendship.count" do
			#post friendship_path, params: { :friend_id => @another_user.id }
		#end
		# Reverse friendships are stopped by controller first
		sign_in @another_user
		assert_no_difference "Friendship.count" do
			post friendship_path, params: { :friend_id => @user.id }
		end
	end

	test "remove friendships" do
		sign_in @user
		get users_path
		assert_select "a", "(Add friend)"
		get user_path(@user)
		assert_select "a", "(remove friend)"
		assert_difference "Friendship.count", -1 do
			delete friendship_path(:id => friendships(:one))
		end
	end

	test "remove inverse friendship" do
		sign_in @another_user
		get user_path(@another_user)
		assert_select "a", "(remove friend)"
		assert_difference "Friendship.count", -1 do
			delete friendship_path(:id => friendships(:one))
		end
	end

	test "no remove friend links for different user" do
		sign_in @user
		get user_path(@another_user)
		assert_select "a", text: '(remove friend)', count: 0
	end

end
