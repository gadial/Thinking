class CreateSessions < ActiveRecord::Migration
  def self.up
    create_table :sessions do |t|
      t.integer :number
      t.integer :registration_enabled
      t.integer :commenting_enables
      t.integer :results_view_enabled
			t.integer :active
			
      t.timestamps
    end
  end

  def self.down
    drop_table :sessions
  end
end
