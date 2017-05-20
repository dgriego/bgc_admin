class AddMemberNumberToParticipants < ActiveRecord::Migration[5.0]
  def change
    add_column :participants, :member_number, :integer
  end
end
