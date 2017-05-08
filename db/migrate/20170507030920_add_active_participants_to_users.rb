class AddActiveParticipantsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :activeParticipants, :integer
  end
end
