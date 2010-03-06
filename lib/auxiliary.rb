class Array
	def count(item)
		self.find_all{|x| x==item}.length
	end
end

class String
  def clear
    temp = delete("<>|").strip
    while temp.sub!("  "," "); end
    temp
  end
end

def expansion_function(n,k,jump)
  #geometric series
  result = 0
  summand = n
  k.times {|i| result += summand; summand /= 2 if i % jump == 0}
  result
end

a = "a  a"
puts a.clear