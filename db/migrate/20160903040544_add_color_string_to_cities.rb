class AddColorStringToCities < ActiveRecord::Migration[5.0]
  def change
    add_column :cities, :color, :string
  end
end
