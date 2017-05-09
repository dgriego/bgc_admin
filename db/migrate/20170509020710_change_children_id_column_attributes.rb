class ChangeChildrenIdColumnAttributes < ActiveRecord::Migration[5.0]
  def change
    remove_column :participant_trips, :participant_id

    add_reference :participant_trips, :participant, index: true, foreign_key: {on_delete: :cascade}
  end
end
