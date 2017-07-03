require 'test_helper'

class FriendshipTest < ActiveSupport::TestCase
	def setup
		@user       = users(:bob)
		@other_user = users(:mike)
		@friendship = Friendship.new(user_id: @user.id, friend_id: @other_user.id)
	end
	test "should be valid" do
		assert @friendship.valid?
	end

	test "must have user_id" do
		@friendship.user_id = nil
		assert_not @friendship.valid?
	end

	test "must have friend_id" do
		@friendship.friend_id = nil
		assert_not @friendship.valid?
	end
end
