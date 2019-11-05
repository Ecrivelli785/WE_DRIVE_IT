class CreateCars < ActiveRecord::Migration[5.2]
  def change
    create_table :cars do |t|
      t.string :brand
      t.string :model
      t.string :transmission
      t.string :poliza
      t.string :green_card
      t.string :fuel_type
      t.string :plate
      t.integer :year
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
