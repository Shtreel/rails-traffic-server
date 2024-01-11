class CreateMapMarkers < ActiveRecord::Migration[7.0]
  def change
    create_table :map_markers do |t|
      t.decimal :latitude, precision: 10, scale: 6, null: false
      t.decimal :longitude, precision: 10, scale: 6, null: false
      t.integer :icon_type, default: 0, null: false
      t.timestamps
    end
  end
end
