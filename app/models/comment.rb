class Comment < ActiveRecord::Base
  belongs_to :submitter,
             :class_name => "User"
  belongs_to :target,
            :class_name => "User"
end
