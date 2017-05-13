class AddAlternateToParticipantTrips < ActiveRecord::Migration[5.0]
  def change
    add_column :participant_trips, :alternate, :boolean, default: false
  end
end
