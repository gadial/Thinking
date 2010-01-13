class Session < ActiveRecord::Base
	has_many :comments
	has_many :users
	def Session.current
		Session.find_by_active(1)
	end
end
