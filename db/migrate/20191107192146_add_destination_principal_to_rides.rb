class AddDestinationPrincipalToRides < ActiveRecord::Migration[5.2]
  def change
    add_column :rides, :destination_principal, :string
  end
end
