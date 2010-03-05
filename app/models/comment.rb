class Comment < ActiveRecord::Base
  belongs_to :submitter,
             :class_name => "User"
  belongs_to :target,
            :class_name => "User"
	belongs_to :session
  def Comment.number_of_comments(min_date = nil)
    Comment.find(:all).reject{|c| min_date and c.created_at <= min_date}.length
  end
end
