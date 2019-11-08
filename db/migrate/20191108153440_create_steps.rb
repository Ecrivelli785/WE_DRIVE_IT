class CreateSteps < ActiveRecord::Migration[5.2]
  def change
    create_table :steps do |t|
      t.float :latitude
      t.float :longitude
      t.string :address
      t.integer :order
      t.references :ride, foreign_key: true

      t.timestamps
    end
  end
end
