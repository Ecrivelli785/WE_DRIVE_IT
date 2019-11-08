class RemoveOriginAndDestinationFromRides < ActiveRecord::Migration[5.2]
  def change
    remove_column :rides, :origin
    remove_column :rides, :destination
  end
end
