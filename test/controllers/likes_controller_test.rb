require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
	include Devise::Test::IntegrationHelpers

	def setup
		@bob = users(:bob)
		@post = posts(:sally_post_0)
	end

  test "must be logged in to like a post" do
  	assert_raise do
  		post like_path(:post_id => @post.id)
  	end
  end

  test "like a post (but only once)" do
  	sign_in @bob
  	assert_difference "Like.count", 1 do
  		post like_path(:post_id => @post.id)
  	end
  	assert_raise do
  		post like_path(:post_id => @post.id)
  	end
  end

  #would like to test for like_path, having trouble with assert_select
end
