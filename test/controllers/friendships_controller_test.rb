require 'test_helper'

class FriendshipsControllerTest < ActionDispatch::IntegrationTest
	include Devise::Test::IntegrationHelpers
	def setup
		@bob = users(:bob)
		@mike = users(:mike)
		@sally = users(:sally) # already friends
	end

	test "must be logged in" do
		assert_no_difference "Friendship.count" do
			post friendship_path, params: { :friend_id => @mike.id }
		end
		sign_in @bob
		assert_difference "Friendship.count", 1 do
			post friendship_path, params: { :friend_id => @mike.id }
		end
		assert Notice.count == 1
	end
	 
	test "can't have duplicate friendships" do
		sign_in @bob
		assert_raise do
			post friendship_path, params: { :friend_id => @sally.id }
		end
		# Reverse friendships are stopped by controller first (not sure if still needed)
		sign_in @sally
		assert_no_difference "Friendship.count" do
			post friendship_path, params: { :friend_id => @bob.id }
		end
	end

	test "remove friendships" do
		sign_in @bob
		get users_path
		assert_select "a", "(Add friend)"
		get user_path(@bob)
		assert_select "a", "(remove friend)"
		assert_difference "Friendship.count", -1 do
			delete friendship_path(:id => friendships(:one))
		end
	end

	test "remove inverse friendship" do
		sign_in @sally
		get user_path(@sally)
		assert_select "a", "(remove friend)"
		assert_difference "Friendship.count", -1 do
			delete friendship_path(:id => friendships(:one))
		end
	end

	test "no remove friend links for different user" do
		sign_in @bob
		get user_path(@sally)
		assert_select "a", text: '(remove friend)', count: 0
	end

	test "denying friend requests" do
		sign_in @sally
		get user_path(@sally)
		assert_select "a", text: '(Accept)'
		assert_select "a", text: '(Deny)'
		assert_difference "Friendship.count", -1 do
			delete friendship_path(:id => friendships(:three))
		end
		assert_select "a", text: '(Accept)', count: 0
		assert_select "a", text: '(Deny)'  , count: 0
	end

	test "accepting friend requests" do
		sign_in @sally
		get user_path(@sally)
		assert_select "a", text: '(Accept)'
		assert_select "a", text: '(Deny)'
		assert_no_difference "Friendship.count" do
			patch friendship_path(:id => friendships(:three))
		end
		friendships(:three).reload
		assert friendships(:three).accepted?
		assert_redirected_to @sally
		follow_redirect!
		assert_select "a", text: '(remove friend)'
	end
end
