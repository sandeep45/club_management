class CreatePlayDates < ActiveRecord::Migration[5.1]
  def change
    create_table :play_dates do |t|
      t.date :the_date
      t.integer :club_id
      t.string :title
    end
    add_index :play_dates, :club_id
  end
end
