class SessionsController < Devise::SessionsController
  include MobileAuthenticationHelper

  skip_before_action :verify_signed_out_user, only: [:destroy]

  def create
    user = warden.authenticate(auth_options)

    if user
      sign_in(:user, user)

      render json: user.as_json(:only => user_render_attrs), status: 200
    else
      render json: {error: 'Incorrect login credentials'} , status: 422
    end
  end

  def destroy
    if is_mobile_app?
      render invalidate_mobile_app_session
      return
    end
    sign_out(:user)
    respond_to_on_destroy
  end

  def logout
    if is_mobile_app?
      render invalidate_mobile_app_session
      return
    end
    sign_out(:user)
    render json: nil
  end

  private
  def user_render_attrs
    attrs = %i(id first_name last_name email address gender)
    attrs << :authentication_token if is_mobile_app?
    attrs
  end

  def invalidate_mobile_app_session
    if current_user
      current_user.update(authentication_token: nil)
      sign_out(:user)
      { status: 204, json: nil }
    else
      { status: 422, json: { error: 'Invalid token.' } }
    end
  end
end
