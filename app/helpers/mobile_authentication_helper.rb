module MobileAuthenticationHelper
  def authenticate_user_from_token
    user_email = request.headers["HTTP_APP_EMAIL"]
    user_token = request.headers["HTTP_APP_TOKEN"]
    user       = user_email && User.find_by(email: user_email)
    # Use Devise.secure_compare to mitigate timing attacks.

    if user && Devise.secure_compare(user.authentication_token, user_token)
      sign_in(:user, user)
    end
  end

  def is_mobile_app?
    !!(request.headers["HTTP_APP"] =~ /^(ios|android).*$/)
  end

  def require_user
    if is_mobile_app?
      render_unauthorized if current_user.nil?
    else
      authenticate_user!
    end
  end

  def render_unauthorized
    render json: {error: 'Unauthorized user'}, status: :unauthorized
  end
end
