require 'test_helper'

class CommentTest < ActiveSupport::TestCase
	def setup
		@comment = Comment.new(user_id: users(:bob).id,
							   post_id: posts(:sally_post_0).id,
							   content: "Test post for testing")
	end
	test "should be valid" do
		assert @comment.valid?
	end

	test "must have user_id" do
		@comment.user_id = " "
		assert_not @comment.valid?
	end

	test "must have post_id" do
		@comment.post_id = " "
		assert_not @comment.valid?
	end

	test "can't be blank" do
		@comment.content = " "
		assert_not @comment.valid?
	end
end
