class AddUserIdToChildren < ActiveRecord::Migration[5.0]
  def change
    add_reference :children, :user, foreign_key: true
  end
end
