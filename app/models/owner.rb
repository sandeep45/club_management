# ## Schema Information
#
# Table name: `owners`
#
# ### Columns
#
# Name                          | Type               | Attributes
# ----------------------------- | ------------------ | ---------------------------
# **`id`**                      | `integer`          | `not null, primary key`
# **`email`**                   | `string`           |
# **`created_at`**              | `datetime`         | `not null`
# **`updated_at`**              | `datetime`         | `not null`
# **`provider`**                | `string`           | `default("email"), not null`
# **`uid`**                     | `string`           | `default(""), not null`
# **`encrypted_password`**      | `string`           | `default(""), not null`
# **`reset_password_token`**    | `string`           |
# **`reset_password_sent_at`**  | `datetime`         |
# **`remember_created_at`**     | `datetime`         |
# **`sign_in_count`**           | `integer`          | `default(0), not null`
# **`current_sign_in_at`**      | `datetime`         |
# **`last_sign_in_at`**         | `datetime`         |
# **`current_sign_in_ip`**      | `string`           |
# **`last_sign_in_ip`**         | `string`           |
# **`tokens`**                  | `json`             |
#
# ### Indexes
#
# * `index_owners_on_email` (_unique_):
#     * **`email`**
# * `index_owners_on_reset_password_token` (_unique_):
#     * **`reset_password_token`**
# * `index_owners_on_uid_and_provider` (_unique_):
#     * **`uid`**
#     * **`provider`**
#

class Owner < ApplicationRecord

  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable

  include DeviseTokenAuth::Concerns::User

  has_many :clubs, :dependent => :destroy
  has_many :members, through: :clubs
  has_many :checkins, through: :members

end
