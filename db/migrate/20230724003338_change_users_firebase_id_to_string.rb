class ChangeUsersFirebaseIdToString < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :firebase_id, :string
  end
end
