class AddNonNullToProvince < ActiveRecord::Migration[7.0]
  def change
    Vehicle.where(province: nil).update_all(province: "ontario")
    change_column_null :vehicles, :province, false
  end
end
