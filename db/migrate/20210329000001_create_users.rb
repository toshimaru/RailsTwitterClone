# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false, index: { unique: true }
      t.string :slug, null: false, index: { unique: true }
      t.string :password_digest, null: false
      t.string :remember_digest, index: true

      t.timestamps
    end
  end
end
