class CreateMaps < ActiveRecord::Migration[5.0]
  def change
    create_table :maps do |t|
      t.string :name
      t.text :description
      t.text :svg

      t.timestamps
    end
  end
end
