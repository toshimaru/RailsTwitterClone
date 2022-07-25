# frozen_string_literal: true

class CreateJoinTableRelationships < ActiveRecord::Migration[6.1]
  def change
    create_join_table :followers, :followeds, table_name: :relationships do |t|
      t.index [:follower_id, :followed_id], unique: true
      t.index :followed_id
    end
  end
end
