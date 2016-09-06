class AddIslandBooleanToMaps < ActiveRecord::Migration[5.0]
  def change
    add_column :maps, :island, :boolean
  end
end
