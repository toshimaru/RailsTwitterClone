class RenameMicropostsTable < ActiveRecord::Migration
  def change
    rename_table :microposts, :tweets
  end
end
