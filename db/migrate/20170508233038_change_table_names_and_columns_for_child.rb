class ChangeTableNamesAndColumnsForChild < ActiveRecord::Migration[5.0]
  def change
    rename_column :child_trips, :child_id, :participant_id

    rename_table :children, :participants
    rename_table :child_trips, :participant_trips
  end
end
