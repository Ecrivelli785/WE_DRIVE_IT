class UserMailer < ApplicationMailer
  def welcome
    @user = User.last
    if @user.full_name
      mail(to: @user.email, subject: "Bienvenido #{@user.full_name.capitalize}")
    else
      mail(to: @user.email, subject: "Bienvenido #{@user.email}")
    end
  end
end
