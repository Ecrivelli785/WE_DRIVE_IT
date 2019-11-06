class AddContentToRides < ActiveRecord::Migration[5.2]
  def change
    add_column :rides, :content, :string
  end
end
