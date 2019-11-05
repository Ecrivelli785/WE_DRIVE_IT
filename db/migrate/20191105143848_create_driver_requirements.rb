class CreateDriverRequirements < ActiveRecord::Migration[5.2]
  def change
    create_table :driver_requirements do |t|
      t.boolean :quiz_certification
      t.string :license
      t.string :record_police
      t.integer :bank_account
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
