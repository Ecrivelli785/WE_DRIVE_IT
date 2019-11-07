class AddStartDayToRides < ActiveRecord::Migration[5.2]
  def change
    add_column :rides, :start_day, :string
  end
end
