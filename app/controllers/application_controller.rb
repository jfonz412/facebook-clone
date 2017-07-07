class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # https://stackoverflow.com/questions/16471498/adding-extra-registration-fields-with-devise
  # if using devise_controller, do this before anything...
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  # whitelists custom parameters for devise
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
