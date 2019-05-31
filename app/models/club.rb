# ## Schema Information
#
# Table name: `clubs`
#
# ### Columns
#
# Name                             | Type               | Attributes
# -------------------------------- | ------------------ | ---------------------------
# **`id`**                         | `integer`          | `not null, primary key`
# **`name`**                       | `string`           |
# **`created_at`**                 | `datetime`         | `not null`
# **`updated_at`**                 | `datetime`         | `not null`
# **`owner_id`**                   | `integer`          |
# **`keyword`**                    | `string`           |
# **`simply_compete_username`**    | `string`           |
# **`simply_compete_password`**    | `string`           |
# **`simply_compete_league_id`**   | `string`           |
# **`default_amount_to_collect`**  | `integer`          | `default(10)`
#
# ### Indexes
#
# * `index_clubs_on_owner_id`:
#     * **`owner_id`**
#
# ### Foreign Keys
#
# * `fk_rails_...`:
#     * **`owner_id => owners.id`**
#

class Club < ApplicationRecord

  belongs_to :owner

  has_many :members, :dependent => :destroy
  has_many :checkins, through: :members
  has_many :play_dates, :inverse_of => :club

end
