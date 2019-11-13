class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]
  def home
  end

  def dashboard
    @rides = Ride.joins(:user).where(rides: { status: "PENDIENTE" }).where.not(users: { mp_card_id: nil })
    @myrides = Ride.where(driver: current_user)
  end

  def profile
  end
end
