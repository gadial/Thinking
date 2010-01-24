#extending session to handle the matching game
class ExtendSession < ActiveRecord::Migration
  def self.up
    rename_column :sessions, :results_view_enabled, :commenting_results_view_enabled
    add_column :sessions, :matching_enabled, :boolean, :default => false
    add_column :sessions, :matching_results_view_enabled, :boolean, :default => false
  end

  def self.down
    rename_column :sessions, :commenting_results_view_enabled, :results_view_enabled
    remove_column :sessions, :matching_enabled
    remove_column :sessions, :matching_results_view_enabled
  end
end