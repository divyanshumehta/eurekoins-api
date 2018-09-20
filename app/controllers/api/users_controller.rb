class Api::UsersController < Api::ApplicationController

	def register
		res = {}
		token = params[:token]
		user = User.new
		user.name = params[:user][:name]
		user.email = params[:user][:image]
		user.token = params[token]
		user.image = params[:user][:image]
		if params[:user][:referred_invite_code]
			t = Transaction.new
			t.user = User.first
			t.recevier = user.email
			user.coins = 50
			t.save
		end
		user.coins = 0
		usr_code = ""
		user.name.split(" ").each do |word|
			usr = usr + word[0]
		end
		user.invite_code = "AVSKR" + usr_code
		unique_invite_code = User.find_by_invite_code(user.invite_code)
		unless unique_invite_code
			user.invite_code += User.last.id.to_s
		end
		user.save

		# Response 0 means successfully registered user
		res[:status] = "0"
		render json: res
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
		users = User.where("name ~ ?",params[:pattern])
		if users
			res[:status] = "0"
			res[:users] = users.pluck(:name, :email)
		else
			res[:status] = "1"
		end
		render json: res
	end
end
