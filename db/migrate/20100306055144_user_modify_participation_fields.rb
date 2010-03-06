class UserModifyParticipationFields < ActiveRecord::Migration
  def self.up
    add_column :users, :enabled, :boolean, :default => false
    add_column :users, :shown, :boolean, :default => true
    remove_column :users, :participates
  end

  def self.down
    add_column :users, :participates, :integer
    remove_column :users, :enabled
    remove_column :users, :shown
  end
end
