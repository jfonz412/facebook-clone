require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(email: "foo@bar.com", password: "pass123")
  end

  test "get root url" do
  	get root_url
  	assert_response :success
    assert_select "title", "Home"
    assert_select "a[href=?]", home_path, count: 2
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
  end

  test "get about page" do
  	get about_path
  	assert_response :success
    assert_select "title", "About"
  end

  test "get contact" do
  	get contact_path
  	assert_response :success
    assert_select "title", "Contact"
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

  #test "layout when logged in" do
      # need a way to sign in user
      #assert_select "a[href=?]", home_path, count: 2
      #assert_select "a[href=?]", about_path
      #assert_select "a[href=?]", contact_path
      #assert_select "a[href=?]", destroy_user_session_path
  #end
end
