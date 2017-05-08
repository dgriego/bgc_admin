class DropTableRoleUsers < ActiveRecord::Migration[5.0]
  def change
    drop_table :role_users
  end
end
