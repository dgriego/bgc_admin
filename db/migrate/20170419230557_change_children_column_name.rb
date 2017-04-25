class ChangeChildrenColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :children, :name, :first_name
  end
end
