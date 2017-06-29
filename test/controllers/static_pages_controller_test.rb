require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "get root url" do
  	get root_url
  	assert_response :success
    assert_select "title", "Home"
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
