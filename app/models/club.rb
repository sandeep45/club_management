# ## Schema Information
#
# Table name: `clubs`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`id`**          | `integer`          | `not null, primary key`
# **`name`**        | `string`           |
# **`created_at`**  | `datetime`         | `not null`
# **`updated_at`**  | `datetime`         | `not null`
# **`owner_id`**    | `integer`          |
# **`keyword`**     | `string`           |
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

end
