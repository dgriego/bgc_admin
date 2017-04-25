class CreateChildTrips < ActiveRecord::Migration[5.0]
  def change
    create_table :child_trips do |t|
      t.integer :trip_id
      t.integer :children_id
      t.boolean :primary, default: true
    end
  end
end
