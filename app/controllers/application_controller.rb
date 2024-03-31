class ApplicationController < ActionController::API
  include Pundit::Authorization
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  private

  def authenticate_user!

    payload = JsonWebToken.decode(auth_token)
    @current_user = User.find(payload["sub"])
  rescue JWT::DecodeError
    render json: {errors: ['Not Authenticated']}, status: :unauthorized
  end

  def auth_token
    @auth_token ||= request.headers.fetch("Authorization", "").split(" ").last
  end

  def current_user
    @current_user
  end

  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name avatar])
  end

end
