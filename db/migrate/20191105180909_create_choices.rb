class CreateChoices < ActiveRecord::Migration[5.2]
  def change
    create_table :choices do |t|
      t.string :declaration
      t.boolean :correct
      t.references :question, foreign_key: true

      t.timestamps
    end
  end
end
