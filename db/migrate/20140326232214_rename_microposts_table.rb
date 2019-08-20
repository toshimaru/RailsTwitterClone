class RenameMicropostsTable < ActiveRecord::Migration[4.2]
  def change
    rename_table :microposts, :tweets
  end
end
