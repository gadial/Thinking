class Array
	def count(item)
		self.find_all{|x| x==item}.length
	end
end

class String
  def clear
    delete("<>\r")
  end
end