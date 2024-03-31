# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  skip_before_action :authenticate_user!, only: [:create, :new]

  include RackSessionsFix
  respond_to :json

  private

  def respond_with(current_user, _opts = {})
    if resource.persisted?
      render json: {
        status: {code: 200, message: I18n.t('controllers.users.registrations.created_successfully')},
        data: { 
          user: UserSerializer.new(current_user).serializable_hash[:data][:attributes]
        }
      }
    else
      render json: {
        status: {message: I18n.t('controllers.users.registrations.not_created', errors: current_user.errors.full_messages.to_sentence)}
      }, status: :unprocessable_entity
    end
  end
end