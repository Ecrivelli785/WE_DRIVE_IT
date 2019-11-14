# Preview all emails at http://localhost:3000/rails/mailers/ride_mailer
class RideMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/ride_mailer/create_confirmation
  def create_confirmation
    RideMailer.create_confirmation
  end

end
