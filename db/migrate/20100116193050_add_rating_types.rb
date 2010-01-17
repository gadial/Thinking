class AddRatingTypes < ActiveRecord::Migration
  def self.up
    File.open("public/rating_types.dat","r"){|file| file.read.split("\n")}.collect{|x| x.split(",")}.each do |type|
      RatingType.new do |rt|
        rt.male_name = type[0]
        rt.female_name = type[0]
        rt.save
      end
    end
  end

  def self.down
    RatingType.delete_all
  end
end
