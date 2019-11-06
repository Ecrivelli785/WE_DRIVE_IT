class AddTotalTimeRideToRide < ActiveRecord::Migration[5.2]
  def change
    add_column :rides, :total_time_ride, :integer
  end
end
