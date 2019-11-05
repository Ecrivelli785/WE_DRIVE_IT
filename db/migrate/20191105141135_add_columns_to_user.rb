class AddColumnsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :full_name, :string
    add_column :users, :city, :string
    add_column :users, :address, :string
    add_column :users, :dni, :string
    add_column :users, :role, :string
  end
end
