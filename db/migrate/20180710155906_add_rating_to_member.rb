class AddRatingToMember < ActiveRecord::Migration[5.1]
  def change
    add_column :members, :rating, :integer, :default => 0
  end
end
