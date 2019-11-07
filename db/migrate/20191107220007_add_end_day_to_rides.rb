class AddEndDayToRides < ActiveRecord::Migration[5.2]
  def change
    add_column :rides, :end_day, :string
  end
end
