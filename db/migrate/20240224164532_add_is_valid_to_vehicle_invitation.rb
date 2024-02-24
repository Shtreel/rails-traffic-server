class AddIsValidToVehicleInvitation < ActiveRecord::Migration[7.0]
  def change
    add_column :vehicle_invitations, :is_valid, :bool, null: false, default: true
  end
end
