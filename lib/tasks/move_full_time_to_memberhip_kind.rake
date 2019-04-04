desc "move_full_time_to_membership_kind"
task :move_full_time_to_membership_kind => [:environment]  do
  Member.where(:full_time => true).update_all :membership_kind => 'full_time'
  Member.where(:full_time => false).update_all :membership_kind => 'part_time'
end