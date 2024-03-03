class AddPushTokenToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :push_token, :string
  end
end
