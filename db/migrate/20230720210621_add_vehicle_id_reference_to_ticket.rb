class AddVehicleIdReferenceToTicket < ActiveRecord::Migration[7.0]
  def change
    remove_column :tickets, :vehicle_id
    add_reference :tickets, :vehicle, foreign_key: true
  end
end
