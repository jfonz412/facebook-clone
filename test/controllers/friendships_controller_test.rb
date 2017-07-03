require 'test_helper'

class FriendshipsControllerTest < ActionDispatch::IntegrationTest
	include Devise::Test::IntegrationHelpers
	def setup
		@user = users(:bob)
		@other_user = users(:mike)
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
end
