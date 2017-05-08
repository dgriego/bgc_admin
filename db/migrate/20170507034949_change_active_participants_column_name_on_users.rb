class ChangeActiveParticipantsColumnNameOnUsers < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :activeParticipants, :active_participants
  end
end
