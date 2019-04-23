class AddSimplyCompeteUsernamePassword < ActiveRecord::Migration[5.1]
  def change
    add_column :clubs, :simply_compete_username, :string
    add_column :clubs, :simply_compete_password, :string
    add_column :clubs, :simply_compete_league_id, :string
  end
end
