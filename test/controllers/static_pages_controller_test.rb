require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
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
end
