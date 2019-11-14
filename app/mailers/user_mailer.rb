class UserMailer < ApplicationMailer
  def welcome
    @user = User.last
    mail(to: @user.email, subject: "Bienvenido #{@user.full_name.capitalize}")
  end
end
