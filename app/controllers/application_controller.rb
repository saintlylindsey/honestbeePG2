class ApplicationController < ActionController::Base
	include MobileAuthenticationHelper

  protect_from_forgery with: :null_session

  before_action :authenticate_user_from_token, if: :is_mobile_app?
end
