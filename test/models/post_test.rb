require 'test_helper'

class PostTest < ActiveSupport::TestCase
	def setup
		@post = users(:bob).posts.build(content: "This is a test")
	end

	test "should be valid" do
		assert @post.valid?
	end

	test "must have an author" do
		@post.user_id = " "
		assert_not @post.valid?
	end

	test "content must not be blank" do
		@post.content = " "
		assert_not @post.valid?
	end

	test "cannot be more than 8000 chars" do
		@post.content = "a" * 9000 # No commas!
		assert_not @post.valid?
	end

end
