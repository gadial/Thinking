class Rating < ActiveRecord::Base
  has_one :rating_type
end
