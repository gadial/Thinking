class FixSessionTable < ActiveRecord::Migration
  def self.up
    remove_column :sessions, :registration_enabled
    remove_column :sessions, :commenting_enabled
    remove_column :sessions, :results_view_enabled
    remove_column :sessions, :active

    add_column :sessions, :registration_enabled, :boolean, :default => false
    add_column :sessions, :commenting_enabled, :boolean, :default => false
    add_column :sessions, :results_view_enabled, :boolean, :default => false
    add_column :sessions, :active, :boolean, :default => false
  end

  def self.down
    remove_column :sessions, :registration_enabled
    remove_column :sessions, :commenting_enabled
    remove_column :sessions, :results_view_enabled
    remove_column :sessions, :active

    add_column :sessions, :registration_enabled, :integer
    add_column :sessions, :commenting_enabled, :integer
    add_column :sessions, :results_view_enabled, :integer
    add_column :sessions, :active, :integer
  end
end
