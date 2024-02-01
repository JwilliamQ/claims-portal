class RenameUsersToUser < ActiveRecord::Migration[7.1]
  def change
    rename_table :Users, :users
  end
end
