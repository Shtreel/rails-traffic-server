class CreateVehicleInvitations < ActiveRecord::Migration[7.0]
  def change
    create_table :vehicle_invitations do |t|
      t.string :code, null: false, uniqueness: true
      t.references :vehicle, index: true, foreign_key: true, null: false

      t.timestamps
    end
  end
end
