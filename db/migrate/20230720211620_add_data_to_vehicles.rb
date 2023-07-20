class AddDataToVehicles < ActiveRecord::Migration[7.0]
  def change
    add_column :vehicles, :licence_plate, :string
    add_column :vehicles, :make, :string
    add_column :vehicles, :model, :string
    add_column :vehicles, :year, :int
    add_index :vehicles, :licence_plate, unique: true
  end
end
