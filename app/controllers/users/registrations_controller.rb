class Users::RegistrationsController < Devise::RegistrationsController
 before_filter :configure_permitted_parameters

  protected

	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :image])
		devise_parameter_sanitizer.permit(:account_update, keys: [:name, :image])
	end


end

