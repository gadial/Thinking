class AddUsersViewType < ActiveRecord::Migration
  def self.up
    add_column :users, :view_type, :string, :default => "normal_view"
  end

  def self.down
    remove_column :users, :view_type
  end
end
