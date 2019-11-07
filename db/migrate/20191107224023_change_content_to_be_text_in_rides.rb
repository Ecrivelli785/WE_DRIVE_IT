class ChangeContentToBeTextInRides < ActiveRecord::Migration[5.2]
  def change
    change_column :rides, :content, :text
  end
end
