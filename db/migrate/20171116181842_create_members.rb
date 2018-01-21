class CreateMembers < ActiveRecord::Migration[5.1]
  def change
    create_table :members do |t|
      t.string :name
      t.string :email
      t.references :club, foreign_key: true
      t.string :phone_number
      t.boolean :full_time, default: false

      t.timestamps
    end
  end
end
