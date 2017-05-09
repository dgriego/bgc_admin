class RemoveUserIdFromParticipants < ActiveRecord::Migration[5.0]
  def change
    remove_column :participants, :user_id
  end
end
