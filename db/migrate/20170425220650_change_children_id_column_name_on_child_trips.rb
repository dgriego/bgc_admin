class ChangeChildrenIdColumnNameOnChildTrips < ActiveRecord::Migration[5.0]
  def change
    rename_column :child_trips, :children_id, :child_id
  end
end
