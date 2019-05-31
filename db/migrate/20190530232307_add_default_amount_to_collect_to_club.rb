class AddDefaultAmountToCollectToClub < ActiveRecord::Migration[5.1]
  def change
    add_column :clubs, :default_amount_to_collect, :integer, :default => 10
  end
end
