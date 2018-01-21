class AddOwnerIdToClub < ActiveRecord::Migration[5.1]
  def change
    add_reference :clubs, :owner, foreign_key: true
  end
end
