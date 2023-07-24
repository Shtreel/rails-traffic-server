class AddDriversLicenceNumberToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :drivers_licence_number, :string
  end
end
