class ChangeTotalPriceTypeInRides < ActiveRecord::Migration[5.2]
  def change
    remove_column :rides, :total_price
    add_monetize :rides, :total_price, currency: { present: false }
  end
end
