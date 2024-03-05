class UserMailer < ApplicationMailer

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: I18n.t('user_mailer.confirmation_instructions.subject'))
  end
end
