class Array
	def choose_at_random
		self[Kernel.rand(length)]
	end
end
def rand_in_range(range)
	Kernel.rand(range.max-range.min) + range.min
end

class AddComments < ActiveRecord::Migration
	@comments_par_user = 10..15
  def self.up
		down
		comments_array = File.open("public/comments.dat","r"){|file| file.read.split("\n")}
		user_array = User.find(:all)
		user_array.each do |user|
			rand_in_range(@comments_par_user).times do
				Comment.new do |comment|
					comment.text = comments_array.choose_at_random
					comment.submitter = user_array.choose_at_random
					comment.target = user
					comment.save
				end
			end
		end
  end

  def self.down
		Comment.delete_all
  end
end
