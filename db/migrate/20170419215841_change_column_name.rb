class ChangeColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :roles, :type, :name
    rename_column :users, :username, :first_name
  end
end
