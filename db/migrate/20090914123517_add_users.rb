class AddUsers < ActiveRecord::Migration
  def self.up
    down
    users = File.open("public/users.dat","r") {|file| file.read.split("\n")}
    users.collect!{|line| line.split("\t")}
    users.each do |user_data|
      User.new do |user|
        user.username = user_data[0]
        user.password = user_data[1]
        user.save
      end
    end
  end

  def self.down
    User.delete_all
  end
end
