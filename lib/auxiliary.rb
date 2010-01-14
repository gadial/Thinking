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

def expansion_function(n,k)
  #geometric series
  result = 0
  summand = n
  k.times {result += summand; summand /= 2}
  result
end