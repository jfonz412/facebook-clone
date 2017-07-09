require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
	include Devise::Test::IntegrationHelpers

	def setup
		@bob = users(:bob)
		@sally = users(:sally)
		@mike = users(:mike)
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

	test "user profile feed" do 
		sign_in @bob
		get user_path @bob
		assert_match "This is post number 0 for bob", response.body
		assert_match "This is post number 9 for bob", response.body
		assert_no_match "This is post number 0 for sally", response.body
		assert_no_match "This is post number 0 for mike", response.body
	end

	test "home feed" do
		sign_in @bob
		get root_url
		assert_match "This is post number 0 for bob", response.body
		assert_match "This is post number 9 for bob", response.body
		assert_match "This is post number 0 for sally", response.body
		assert_no_match "This is post number 0 for mike", response.body
		# testing other side of the relationship
		sign_in @sally
		get root_url
		assert_match "This is post number 0 for bob", response.body
		assert_match "This is post number 9 for bob", response.body
		assert_match "This is post number 0 for sally", response.body
		assert_no_match "This is post number 0 for mike", response.body
		patch friendship_path(:id => friendships(:three))
		get root_url
		assert_match "This is post number 0 for mike", response.body
		sign_in @mike
		assert_match "This is post number 0 for sally", response.body
		assert_match "This is post number 0 for mike", response.body
	end
end
