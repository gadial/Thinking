class UserAddAvatarLink < ActiveRecord::Migration
  def self.up
    add_column :users, :avatar_link, :string, :default => ""
  end

  def self.down
    remove_column :users, :avatar_link
  end
end
