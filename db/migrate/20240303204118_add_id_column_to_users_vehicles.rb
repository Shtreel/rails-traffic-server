class AddIdColumnToUsersVehicles < ActiveRecord::Migration[7.0]
  def change
    add_column :users_vehicles, :id, :primary_key
  end
end
