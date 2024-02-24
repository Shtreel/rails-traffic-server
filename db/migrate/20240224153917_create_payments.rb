class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.string :payment_intent_id, null: false
      t.references :ticket, index: true, foreign_key: true, null: false
      t.timestamps
    end
  end
end
