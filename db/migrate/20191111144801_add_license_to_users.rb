class AddLicenseToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :license, :string
  end
end
