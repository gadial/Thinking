class Array
	def count(item)
		self.find_all{|x| x==item}.length
	end
end