class AddLeagueStuffToMember < ActiveRecord::Migration[5.1]
  def change
    rename_column :members, :rating, :league_rating
    add_column :members, :usatt_number, :integer
  end
end
