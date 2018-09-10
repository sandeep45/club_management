class AddTableNumberToMember < ActiveRecord::Migration[5.1]
  def change
    add_column :members, :table_number, :integer
  end
end
