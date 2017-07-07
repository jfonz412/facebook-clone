require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
	include Devise::Test::IntegrationHelpers

	def setup
		@bob = users(:bob)
	end

	test "must be logged in" do
		get root_url
		assert_select "textarea", count: 0
		assert_no_difference "Post.count" do
			post posts_path, params: { user_id: @bob.id,
									   content: "Not logged in" }
		end
	end

	test "post form on home and profile pages when logged in" do
		sign_in @bob
		get root_url
		assert_select "textarea"
		get user_path(@bob)
		assert_select "textarea"
	end

	test "valid post" do
		sign_in @bob
		get root_url
		assert_difference "Post.count", 1 do
			post posts_path, params: { user_id: @bob.id,
									   post: { content: "This is a valid post!" } }
		end		
		get user_path(@bob)
		assert_difference "Post.count", 1 do
			post posts_path, params: { user_id: @bob.id,
									   post: { content: "This is a valid post!" } }
		end
	end
end
