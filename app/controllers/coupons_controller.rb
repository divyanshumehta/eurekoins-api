class CouponsController < ApplicationController

	def avail_coupon
		res = {}
		user = User.find_by_token(params[:token])
		if user
			coupon = Coupon.find_by_code(params[:code])
			if coupon 
				if user.coupons_used.include? coupon.code
					res[:status] = "3"	# User already used this coupon
				else
					if coupon.is_active
						src = User.first
						t = Transaction.new
						t.user = src
						t.receiver = user.email
						t.source = src.email
						t.amount = coupon.amount
						t.save
						user.coupons_used << coupon.code
						user.coins += coupon.amount
						user.save
						res[:status] = "0"				# Used coupon successfully
					else
						res[:status] = "4"				# Couopon Expired
					end
				end
			else
				res[:status] = "2"		# No such coupon code
			end
		else
			res[:status] = "1"		  # No such user
		end
		render json: res
	end
end