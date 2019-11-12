class ChangeStatusToRides < ActiveRecord::Migration[5.2]
  def change
    remove_column :rides, :status
    add_column :rides, :status, :integer
  end
end
