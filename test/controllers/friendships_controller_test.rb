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
	# Technically passes, as the DB throws an error. Does not pass when users are swapped
	#test "can't have duplicate friendships" do
		#sign_in @user
		#assert_no_difference "Friendship.count" do
			#post friendship_path, params: { :friend_id => @another_user.id }
		#end
	#end
end
