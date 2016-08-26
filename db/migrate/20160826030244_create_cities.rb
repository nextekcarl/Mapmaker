class CreateCities < ActiveRecord::Migration[5.0]
  def change
    create_table :cities do |t|
      t.string :name, null: false
      t.references :map, foreign_key: true
      t.text :description
      t.integer :population

      t.timestamps
    end
  end
end
