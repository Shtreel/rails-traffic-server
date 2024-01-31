class AddPrimaryToUsersVehicles < ActiveRecord::Migration[7.0]
  def change
    add_column :users_vehicles, :primary, :boolean, default: false
  end
end
