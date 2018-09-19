class Api::UsersController < Api::ApplicationController

	def register
		res = {}
		token = params[:token]
		puts token
		res[:status] = token
		render json: res
	end
end
