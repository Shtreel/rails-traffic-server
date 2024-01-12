class AddNameToIconMarkers < ActiveRecord::Migration[7.0]
  def change
    add_column :map_markers, :name, :string
  end
end
