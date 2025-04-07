class AddActivationToUsers < ActiveRecord::Migration[6.1]
  def change
    change_table :users, bulk: true do |t|
      t.string :activation_digest
      t.boolean :activated, default: false, null: false
      t.datetime :activated_at
    end
  end
end
