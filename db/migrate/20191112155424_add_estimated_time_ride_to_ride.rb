class AddEstimatedTimeRideToRide < ActiveRecord::Migration[5.2]
  def change
    add_column :rides, :estimated_time_ride, :integer
  end
end
