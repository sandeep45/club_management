class AddAmountCollectedToCheckin < ActiveRecord::Migration[5.1]
  def change
    add_column :checkins, :amount_collected, :integer, :default => 0
  end
end
