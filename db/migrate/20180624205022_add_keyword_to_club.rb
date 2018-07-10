class AddKeywordToClub < ActiveRecord::Migration[5.1]
  def change
    add_column :clubs, :keyword, :string
  end
end
