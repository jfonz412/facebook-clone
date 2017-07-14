require 'test_helper'

class NoticeTest < ActiveSupport::TestCase
	def setup
		@bob = users(:bob)
		@mike = users(:mike)
		@post = posts(:bob_post_0)
		@notice = @mike.notices.build(other_user: @bob, notice_type: "Friendship", type_id: 7)
	end
	test "should be valid" do
		assert @notice.valid?
	end
end
