class CreateOwners < ActiveRecord::Migration[5.1]
  def change
    create_table :owners do |t|
      t.references :club, foreign_key: true
      t.string :email

      t.timestamps
    end
  end
end
