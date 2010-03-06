require 'digest/sha2'
require 'auxiliary'

class User < ActiveRecord::Base
    @@comment_string_seperator = "\n"
    @@comment_string_joiner = " | "
    @@low_amount_of_commenters = 5
    @@new_comment_color = "yellow"
    @@max_comment_size = 80
    has_many  :submitted_comments,
              :class_name => "Comment",
              :foreign_key => "submitter_id",
              :dependent => :destroy
    has_many  :describing_comments,
              :class_name => "Comment",
              :foreign_key => "target_id",
              :dependent => :destroy
    belongs_to :session
						validates_uniqueness_of :name, :on => :create, :message => "שם המשתמש כבר תפוס"
						validates_confirmation_of :password, :message => "הססמא ואישור הססמא אינם תואמים"
						validates_length_of :password, :minimum => 5, :message => "אנא בחרו ססמא שאורכה לפחות חמישה תווים", :on => :create
						validates_presence_of :name, :message => "לא ניתן לבחור שם משתמש ריק"
#            validates_format_of :avatar_link, :with => %r{^$|http\:\/\/forums\.asat\.org\.il\/download\/file\.php\?avatar\=.*\.(jpg|gif|png)}, :message => "יש לספק קישור חוקי לאווטר בפורום"
		def create_new_salt
			self.salt = self.object_id.to_s + Kernel.rand.to_s
		end
		def User.hashed_password(password,salt)
			Digest::SHA256.hexdigest(password + "radio-gaga" + salt)
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
      self.describing_comments.find_all{|comment| submitter == nil or comment.submitter.name == submitter}.collect{|comment| comment.text}.join(@@comment_string_seperator)
    end
    def set_comments(comment_string, submitter = nil)
      comment_string ||=""
      comments = comment_string.split(@@comment_string_seperator).collect{|comment| comment.clear}.reject{|c| c == ""}.uniq
      existing_comments = self.describing_comments.find_all{|comment| submitter == nil or comment.submitter.name == submitter}
      comments_to_delete = existing_comments.find_all{|comment| not comments.include?(comment.text)}
      self.describing_comments.delete(comments_to_delete)
      existing_comments.collect!{|comment| comment.text}
      comments.reject{|comment| existing_comments.include?(comment)}.each do |comment_text|
        Comment.new do |comment|
            comment.text = comment_text[0..@@max_comment_size]
            comment.submitter = User.find_by_name(submitter)
            comment.target = self
            comment.save
        end
      end
    end
		#one sorted comments string with multiplicites
    def number_of_commenting_users
      temp = describing_comments.collect{|comment| comment.submitter_id}.uniq.length
      ((temp >= @@low_amount_of_commenters)?(temp.to_s):("פחות מ-#{@@low_amount_of_commenters}"))
    end
    def describing_comments_list
      describing_comments.sort{|a,b| a.text <=> b.text}
    end
    def describing_comments_text(min_date = nil)
#      describing_comments.reject{|comment| min_date and comment.created_at <= min_date}.collect{|comment| comment.text}
       describing_comments.collect do |c|
         (min_date and c.created_at > min_date)?
           ("<span style=\"background-color:#{@@new_comment_color}\">#{c.text}</span>"):
           (c.text)
       end
    end
		def describing_comments_normal_view(min_date = nil)
			describing_comments_text(min_date).sort.join(@@comment_string_joiner)
		end
		def describing_comments_truncted_view(min_date = nil)
			describing_comments_text(min_date).uniq.sort.join(@@comment_string_joiner)
		end
		#comments string without multiplicities, with repeated comments inflated
		def describing_comments_inflated_view(min_date = nil)
      comments = describing_comments_text(min_date)
			comments.uniq.sort.collect{|comment| "<span style=\"font-size: #{expansion_function(100,comments.count(comment),2)}%\">#{comment}</span>"}.join(@@comment_string_joiner)
		end
    def describing_comments_counted_view(min_date = nil)
      comments = describing_comments_text(min_date)
			comments.uniq.sort.collect{|comment| comment + ((comments.count(comment)>1)?(" (#{comments.count(comment)} פעמים)"):(""))}.join(@@comment_string_joiner)
		end
end
