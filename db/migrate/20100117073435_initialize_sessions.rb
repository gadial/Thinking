class InitializeSessions < ActiveRecord::Migration
  def self.up
    Session.delete_all
    Session.new do |s|
      s.active = true
      s.number = Session.next_number
      s.save
    end
  end

  def self.down
    Session.delete_all
  end
end
