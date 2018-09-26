class Coupon < ApplicationRecord
    
	def is_active
		if Time.now < self.end_time and Time.now>self.start_time
			return true
		else
			return false
		end
	end

end
