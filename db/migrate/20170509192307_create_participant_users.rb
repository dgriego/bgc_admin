class CreateParticipantUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :participant_users do |t|
      t.references :user
      t.references :participant
    end
  end
end
