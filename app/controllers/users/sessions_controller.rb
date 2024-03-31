# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  skip_before_action :authenticate_user!, only: [:create, :new]

  include RackSessionsFix
  respond_to :json

  private
  def respond_with(current_user, _opts = {})
    render json: {
      status: { 
        code: 200, message: I18n.t('controllers.users.sessions.logged_in_successfully'),
        data: { user: UserSerializer.new(current_user).serializable_hash[:data][:attributes]
              }
      }
    }, status: :ok
  end
  def respond_to_on_destroy
    if request.headers['Authorization'].present?
      jwt_payload = JWT.decode(request.headers['Authorization'].split(' ').last, ENV['DEVISE_JWT_SECRET_KEY']).first
      current_user = User.find(jwt_payload['sub'])
    end
    
    if current_user
      render json: {
        status: 200,
        message: I18n.t('controllers.users.sessions.logged_out_successfully')
      }, status: :ok
    else
      render json: {
        status: 401,
        message: I18n.t('controllers.users.sessions.no_active_session')
      }, status: :unauthorized
    end
  end
end
