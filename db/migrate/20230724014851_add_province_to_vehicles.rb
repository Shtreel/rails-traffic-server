class AddProvinceToVehicles < ActiveRecord::Migration[7.0]
  def change
    add_column :vehicles, :province, :string
    remove_index :vehicles, :licence_plate
    add_index :vehicles, [:licence_plate, :province], unique: true
  end
end
