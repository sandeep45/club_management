class DeviseTokenAuthCreateOwners < ActiveRecord::Migration[5.1]

  def up
    ## Required
    add_column :owners, :provider, :string, null: false, default: 'email'
    add_column :owners, :uid, :string, null: false, default: ''

    ## Database authenticatable
    add_column :owners, :encrypted_password, :string, null: false, default: ''

    ## Recoverable
    add_column :owners, :reset_password_token, :string
    add_column :owners, :reset_password_sent_at, :datetime

    ## Rememberable
    add_column :owners, :remember_created_at, :datetime

    ## Trackable
    add_column :owners, :sign_in_count, :integer, null: false, default: 0
    add_column :owners, :current_sign_in_at, :datetime
    add_column :owners, :last_sign_in_at, :datetime
    add_column :owners, :current_sign_in_ip, :string
    add_column :owners, :last_sign_in_ip, :string

    ## Tokens
    add_column :owners, :tokens, :json

    ## Fix existing Data
    Owner.reset_column_information
    Owner.find_each do |user|
      user.uid = user.email
      user.provider = 'email'
      user.save!
    end

    ## Indexes
    add_index :owners, :email,                unique: true
    add_index :owners, [:uid, :provider],     unique: true
    add_index :owners, :reset_password_token, unique: true
  end

  def down
    remove_columns :owners, :provider, :uid, :encrypted_password, :reset_password_token,
                   :reset_password_sent_at, :remember_created_at,
                   :sign_in_count, :current_sign_in_at, :last_sign_in_at ,
                   :current_sign_in_ip , :last_sign_in_ip,
                   :tokens
    remove_index :owners, name: :index_users_on_uid_and_provider
    remove_index :owners, name: :index_users_on_email
    remove_index :owners, name: :index_users_on_reset_password_token
  end

end
