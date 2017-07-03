require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  
  def setup
    @user = users(:bob)
  end

  test 'sign in' do
    sign_in @user

    get '/home'
    assert_response :success
    assert_select "a[href=?]", home_path, count: 2
    assert_select "a[href=?]", users_path
    assert_select "a[href=?]", user_path(@user)
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", destroy_user_session_path
  end

  test "layout links, logged out" do 
    get root_path
    assert_template 'static_pages/home'
      assert_select "a[href=?]", home_path, count: 2
      assert_select "a[href=?]", about_path
      assert_select "a[href=?]", contact_path
      assert_select "a[href=?]", new_user_session_path
      assert_select "a[href=?]", new_user_registration_path
  end
end
