require 'test_helper'

class UserMailerTest < ActionMailer::TestCase

	test "Welcome email" do
		user = users(:bob)
		mail = UserMailer.welcome_email(user)
	  assert_equal ["noreply@example.com"], mail.from
	  assert_match user.name,               mail.body.encoded
	end
end
