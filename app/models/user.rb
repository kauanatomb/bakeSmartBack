class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, 
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist
  
  enum role: { regular: 0, admin: 1 }

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, on: :create

  # after_create :send_welcome_message

  # def send_welcome_message
  #   UserMailer.welcome_email(self).deliver_now
  # end
end
