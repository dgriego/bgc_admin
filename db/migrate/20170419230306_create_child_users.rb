class CreateChildUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :child_users do |t|
      t.integer :children_id
      t.integer :user_id
      t.timestamps
    end
  end
end
