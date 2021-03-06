class UsersController < ApplicationController

	def register
		res = {}
		user = User.new
		user.name = params[:name]
		user.email = params[:email]
		user.token = params[:token]
		user.image = params[:image]
		if User.find_by_email(user.email)
			res[:status] = "1"     	# Email already exists
			render json: res
			return
		end
		if User.find_by_token(user.token)
			res[:status] = "2"		# Token already exists
			render json: res
			return
		end
		user.coins = 0
		host_user = User.find_by_invite_code(params[:referred_invite_code])
		if params[:referred_invite_code] and !params[:referred_invite_code].blank? and host_user
			t = Transaction.new
			t1 = Transaction.new
			t1.user = User.first
			t1.receiver = host_user.email
			t1.amount = 25
			t1.source = User.first.email
			t1.save
			t.user = User.first
			t.receiver = user.email
			t.amount = 25
			t.source = User.first.email
			user.coins = 25
			host_user.coins += 25
			host_user.save
			user.referred_invite_code = params[:referred_invite_code]
			t.save
		end
		user.coins += 50
		usr_code = ""
		user.name.split(" ").each do |word|
			usr_code = usr_code + word[0]
		end
		user.invite_code = "AVSKR" + usr_code.upcase
		if User.find_by_invite_code(user.invite_code)
			user.invite_code += User.last.id.to_s
		end
		if user.save!
			# Response 0 means successfully registered user
			res[:status] = "0"
			render json: res
		else
			res[:status] = "3"
			render json: res
		end
	end

	# Returns ture or false if user with a particular token exists
	def exists
		res = {}
		if User.find_by_token(params[:token])
			res[:status] = "1"
		else
			res[:status] = "0"
		end
		render json: res
	end

	# Returns account balance of the user
	def coins
		res = {}
		user = User.find_by_token(params[:token])
		if user
			res[:status] = "0"
			res[:coins] = user.coins
		else
			res[:status] = "1"
		end
		render json: res
	end

	# Returns list of lists with names and emails of the users
	# matching the regex pattern
	# <return> [ [user1,email1], [user2,email2].....]
	def user_list
		res = {}
		users = User.where("lower(name) ~ ?",params[:pattern].downcase)
		if users
			res[:status] = "0"
			res[:users] = users.pluck(:name, :email, :image)
		else
			res[:status] = "1"
		end
		render json: res
	end

	# Returns the invite code for the user
	def invite_code
		res = {}
		user = User.find_by_token(params[:token])
		if user
			res[:status] = "0"
			res[:invite_code] = user.invite_code
		else
			res[:status] = "1"
		end
		render json: res
	end
end
