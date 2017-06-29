require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
 include Devise::Test::IntegrationHelpers

  test 'sign in' do
    sign_in users(:bob)

    get '/home'
    assert_response :success
    assert_select "a[href=?]", home_path, count: 2
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
