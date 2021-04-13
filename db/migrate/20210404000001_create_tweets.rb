# frozen_string_literal: true

class CreateTweets < ActiveRecord::Migration[6.0]
  def change
    create_table :tweets do |t|
      t.string :content, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps

      t.index [:user_id, :created_at]
    end
  end
end
