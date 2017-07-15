class NoticesController < ApplicationController
  before_action :authenticate_user!
  
  def destroy
  	current_user.notices.delete_all
  	redirect_back(fallback_location: root_url)
  end
end