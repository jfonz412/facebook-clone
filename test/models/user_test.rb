require 'test_helper'

class UserTest < ActiveSupport::TestCase
	def setup
		@user = User.new(email: "jjjjj@bar.com", password: "foobar")
	end
	test "should be valid" do
		assert @user.valid?
	end

	test "email can't be blank" do
		@user.email = " "
		assert_not @user.valid?
	end

	test "email must be valid" do
		@user.email = "abcdefg"
		assert_not @user.valid?
		@user.email = "@fakemail.com"
		assert_not @user.valid?
		@user.email = "foobar.com"
		assert_not @user.valid?
	end

	test "password must be valid" do
		@user.password = " "
		@user.password = "1"
	end
end
