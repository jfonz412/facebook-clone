require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
	def setup
    	@user = User.create(email: "foo@bar.com", 
                        	password: "foobar")
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
		#sign_in_user
	    #assert_select "a[href=?]", home_path, count: 2
	    #assert_select "a[href=?]", about_path
	    #assert_select "a[href=?]", contact_path
	    #assert_select "a[href=?]", destroy_user_session_path
	#end
end
