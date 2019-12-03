class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]
  def home
  end

  def dashboard
    # if condition
    # Le sacamos la segunda aprte de la query porqeu la seed no tienen mercado pago ID y rompía todo.
    # @rides = Ride.joins(:user).where(rides: { status: "PENDIENTE" }).where.not(users: { mp_card_id: nil })
    @rides = Ride.joins(:user).where(rides: { status: "PENDIENTE" }).where.not(users: { mp_card_id: nil })
    @myrides = Ride.where(driver: current_user)
  end

  def profile
  end
end
