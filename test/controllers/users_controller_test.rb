require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
 include Devise::Test::IntegrationHelpers

 def setup
 	@user = users(:bob)
 	@non_friend = users(:mike)
 end

 	test "add user (user index) page" do
		sign_in @user
 		get users_path
 		assert_response :success
 		assert_template 'users/index'
		assert_select 'a', text: '(Add friend)', count: 1
		assert_select "a[href=?]", user_path(@non_friend.id) # non-friend
    assert_select "a[href=?]", friendship_path(:friend_id => @non_friend.id) # add non-friend
    assert_difference "@user.friendships.count",  1 do 
    	post friendship_path params: { friend_id: @non_friend.id }
    end
		assert_select 'a', text: '(Add friend)', count: 0
    sign_in @non_friend
    get users_path
    assert_select 'a', text: '(Add friend)', count: 0
  end

	test "should get user profile when signed in" do
		sign_in @user
		get user_path(@user)
    assert_response :success
    assert_template 'users/show'
    assert_select "a[href=?]", user_path(users(:sally))  # friend
    assert_select "a[href=?]", user_path(users(:stevie)) # inverse friend
	end

	test "must be signed in" do
		get user_path(@user)
    assert_response :redirect
  end

  test "deleting user should delete user's activity" do
    sign_in @user
    post_count = @user.posts.count
    assert_difference "Like.count", 1 do
        post like_path(:post_id => posts(:bob_post_0).id)
    end
    assert_difference "@user.posts.count", -post_count do
      assert_difference "Like.count", -1 do
        delete user_registration_path(@bob)
      end
    end
  end
end
