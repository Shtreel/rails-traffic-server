class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.bigint :firebase_id, index: { unique: true, name: 'unique_firebase_id' }
      t.string :name, null: false
      t.string :phone_number, null: false
      t.string :email, null: false
      t.timestamps
    end
  end
end
