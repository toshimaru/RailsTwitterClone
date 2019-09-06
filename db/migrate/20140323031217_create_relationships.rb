class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships, primary_key: [:follower_id, :followed_id] do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps null: false
    end

    add_index :relationships, :follower_id
    add_index :relationships, :followed_id
  end
end
