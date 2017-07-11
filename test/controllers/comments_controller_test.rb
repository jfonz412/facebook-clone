require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
	include Devise::Test::IntegrationHelpers

	def setup
		@bob = users(:bob)
		@post = posts(:sally_post_0)
		@comment = Comment.new(user_id: @bob.id,
							   post_id: @post.id,
							   content: "Test post for testing")
	end

	test "must be signed in to see comment form" do
		get root_url
		assert_select 'div#comment-form', count: 0
		sign_in @bob
		get root_url
		assert_select 'div#comment-form'
	end

	test "must be signed in to submit comment" do
		assert_no_difference "Comment.count" do
			post comments_path, params: { comment: { content: "This should fail",
																						 	 post_id: @post.id } }
		end
	end

	test "submit a comment" do
		sign_in @bob
		assert_difference "Comment.count", 1 do
			post comments_path, params: { comment: { content: "This should pass",
																						 	 post_id: @post.id } }
		end
	end
end
