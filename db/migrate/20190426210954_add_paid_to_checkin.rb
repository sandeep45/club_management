class AddPaidToCheckin < ActiveRecord::Migration[5.1]
  def change
    add_column :checkins, :paid, :boolean, :default => :false
  end
end
