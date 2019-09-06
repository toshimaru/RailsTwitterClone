class RenameMicropostsTable < ActiveRecord::Migration[5.2]
  def change
    rename_table :microposts, :tweets
  end
end
