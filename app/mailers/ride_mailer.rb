class RideMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.ride_mailer.create_confirmation.subject
  #
  def create_confirmation(ride)
    @ride = ride
    @user = @ride.user
    mail(to: @ride.user.email, subject: "Reserva creada para el #{@ride.start_time.strftime('%B,%D,%H:%M')}!")
  end
end
