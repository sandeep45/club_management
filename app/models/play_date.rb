# ## Schema Information
#
# Table name: `play_dates`
#
# ### Columns
#
# Name            | Type               | Attributes
# --------------- | ------------------ | ---------------------------
# **`id`**        | `integer`          | `not null, primary key`
# **`the_date`**  | `date`             |
# **`club_id`**   | `integer`          |
# **`title`**     | `string`           |
#
# ### Indexes
#
# * `index_play_dates_on_club_id`:
#     * **`club_id`**
#

class PlayDate < ApplicationRecord
  belongs_to :club, :inverse_of => :play_dates  
end
  
