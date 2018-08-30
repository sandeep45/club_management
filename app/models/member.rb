# ## Schema Information
#
# Table name: `members`
#
# ### Columns
#
# Name                  | Type               | Attributes
# --------------------- | ------------------ | ---------------------------
# **`id`**              | `integer`          | `not null, primary key`
# **`name`**            | `string`           |
# **`email`**           | `string`           |
# **`club_id`**         | `integer`          |
# **`phone_number`**    | `string`           |
# **`full_time`**       | `boolean`          | `default(FALSE)`
# **`created_at`**      | `datetime`         | `not null`
# **`updated_at`**      | `datetime`         | `not null`
# **`qr_code_number`**  | `integer`          |
# **`league_rating`**   | `integer`          | `default(0)`
# **`usatt_number`**    | `integer`          |
#
# ### Indexes
#
# * `index_members_on_club_id`:
#     * **`club_id`**
#
# ### Foreign Keys
#
# * `fk_rails_...`:
#     * **`club_id => clubs.id`**
#

class Member < ApplicationRecord
  belongs_to :club
  has_many :checkins, :dependent => :destroy

  validates :qr_code_number, :uniqueness => true, :allow_nil => true, :allow_blank => true
end
