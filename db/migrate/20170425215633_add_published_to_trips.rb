class AddPublishedToTrips < ActiveRecord::Migration[5.0]
  def change
    add_column :trips, :published, :boolean, default: false
  end
end
