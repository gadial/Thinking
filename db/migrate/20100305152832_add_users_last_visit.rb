class AddUsersLastVisit < ActiveRecord::Migration
  def self.up
    add_column :users, :last_visit_to_result_list, :timestamp
  end

  def self.down
    remove_column :users, :last_visit_to_result_list
  end
end
