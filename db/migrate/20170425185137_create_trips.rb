class CreateTrips < ActiveRecord::Migration[5.0]
  def change
    create_table :trips do |t|
      t.string :title
      t.string :location
      t.integer :seats
      t.integer :alt_seats
      t.date :start_date
      t.time :start_time
      t.time :end_time
    end
  end
end
