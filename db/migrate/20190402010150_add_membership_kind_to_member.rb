class AddMembershipKindToMember < ActiveRecord::Migration[5.1]
  def change
    add_column :members, :membership_kind, :string, :default => "part_time"
  end
end
