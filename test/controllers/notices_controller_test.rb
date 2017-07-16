require 'test_helper'

class NoticesControllerTest < ActionDispatch::IntegrationTest
	include Devise::Test::IntegrationHelpers

	def setup
		@bob = users(:bob)
		@mike = users(:mike)
		@notice = @mike.notices.build(other_user: @bob, 
																	notice_type: "Friendship", 
																	type_id: 7)
	end

  # notices are tested in other controller tests where
  # a notice would be created

  test "must be logged in to delete notices" do
  	@notice.save
  	assert_no_difference "Notice.count" do
  		get notices_destroy_path
  	end
  end

  test "delete notices when logged in" do
  	@notice.save
  	sign_in @mike
  	assert_difference "Notice.count", -1 do
  		get notices_destroy_path
  	end
  end
end
