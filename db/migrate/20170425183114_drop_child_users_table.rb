class DropChildUsersTable < ActiveRecord::Migration[5.0]
  def change
    drop_table :child_users
  end
end
