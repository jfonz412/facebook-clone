require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
	include Devise::Test::IntegrationHelpers

	def setup
		@bob = users(:bob)
		@post = posts(:sally_post_0)
	end

  test "must be logged in to like a post" do
    get root_url
    assert_select "a.like-button", count: 0
  	assert_no_difference "Like.count" do
  		post like_path(:post_id => @post.id)
  	end
  end

  test "like a post (but only once)" do
  	sign_in @bob
    get root_url
    assert_select "a.like-button"
  	assert_difference "Like.count", 1 do
  		post like_path(:post_id => @post.id)
  	end
    follow_redirect!
    assert_select "a.like-button", text: "Unlike"
  	assert_raise do
  		post like_path(:post_id => @post.id)
  	end
    assert_difference "Like.count", -1 do
      delete unlike_path(:post_id => @post.id)
    end
  end
end
