class User < ActiveRecord::Base
  @@comment_string_seperator = ", "
#  validates_length_of :username, :within => 3..20
  has_many :submitted_comments,
            :class_name => "Comment",
						:foreign_key => "submitter_id"
  has_many :describing_comments,
            :class_name => "Comment",
						:foreign_key => "target_id"

						validates_uniqueness_of :username, :on => :create, :message => "שם המשתמש כבר תפוס"
						validates_confirmation_of :password, :message => "הססמא ואישור הססמא אינם תואמים"
						validates_length_of :password, :minimum => 5, :message => "אנא בחרו ססמא שאורכה לפחות חמישה תווים"
		def create_new_salt
			self.salt = self.object_id.to_s + Kernel.rand.to_s
		end
		def User.hashed_password(password,salt)
			Digest::SHA1.hexdigest(password + "radio-gaga" + salt)
		end
		def password
			@password
		end
		def password=(pwd)
      pwd = "default_bad_password" if pwd == nil
			@password = pwd
			create_new_salt
			self.password_hash = User.hashed_password(@password, self.salt)
		end
    def comments_string(submitter = nil)
      self.describing_comments.find_all{|comment| submitter == nil or comment.submitter.username == submitter}.collect{|comment| comment.text}.join(", ")
    end
    def set_comments(comment_string, submitter = nil)
      comments_to_delete = self.describing_comments.find_all{|comment| submitter == nil or comment.submitter.username == submitter}
      self.describing_comments.delete(comments_to_delete)
      comment_string ||=""
      comment_string.split(@@comment_string_seperator).collect do |comment_text|
        Comment.new do |comment|
            comment.text = comment_text
            comment.submitter = User.find_by_username(submitter)
            comment.target = self
            comment.save
        end
      end
    end
end
