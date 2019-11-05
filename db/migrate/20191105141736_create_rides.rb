class CreateRides < ActiveRecord::Migration[5.2]
  def change
    create_table :rides do |t|
      t.string :status
      t.string :origin
      t.string :destination
      t.datetime :start_time
      t.datetime :end_time
      t.references :user, foreign_key: true
      t.integer :estimated_price
      t.datetime :actual_start_time
      t.datetime :actual_end_time
      t.integer :total_price
      t.bigint :driver_id, foreign_key: true
      t.references :service_type, foreign_key: true

      t.timestamps
    end
  end
end
