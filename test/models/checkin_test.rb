# ## Schema Information
#
# Table name: `checkins`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`id`**          | `integer`          | `not null, primary key`
# **`member_id`**   | `integer`          |
# **`created_at`**  | `datetime`         | `not null`
# **`updated_at`**  | `datetime`         | `not null`
# **`paid`**        | `boolean`          | `default(FALSE)`
#
# ### Indexes
#
# * `index_checkins_on_member_id`:
#     * **`member_id`**
#
# ### Foreign Keys
#
# * `fk_rails_...`:
#     * **`member_id => members.id`**
#

require 'test_helper'

class CheckinTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
