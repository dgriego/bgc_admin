class AddLastNameToChildren < ActiveRecord::Migration[5.0]
  def change
    add_column :children, :last_name, :string
  end
end
