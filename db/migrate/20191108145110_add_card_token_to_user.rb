class AddCardTokenToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :mp_card_id, :string
    add_column :users, :mp_customer_id, :string
  end
end
