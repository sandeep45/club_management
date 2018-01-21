class RemoveClubIdFromOwner < ActiveRecord::Migration[5.1]
  def change
    remove_column :owners, :club_id, :string
  end
end
