ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  # Does not work!!!
  def sign_in_user
     post user_session_path, 'user[:email]' => "foo@bar.com", 
                           					  'user[:password]' => "foobar"
  end
end
