class RenamePassword < ActiveRecord::Migration[4.2]
  def change
    rename_column :users, :password, :password_digest
  end
end
