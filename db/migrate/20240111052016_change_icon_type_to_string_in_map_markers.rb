class ChangeIconTypeToStringInMapMarkers < ActiveRecord::Migration[7.0]
  def change
    change_column :map_markers, :icon_type, :string
  end
end
