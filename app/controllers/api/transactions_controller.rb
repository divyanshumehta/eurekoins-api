class Api::TransactionsController < Api::ApplicationController

    def transfer
        res = {}
        src_user = User.find_by_token(params[:token])
        if src_user.nil?
            res[:status] = "1"  # No such current user
            render json: res
            return
        end
        if params[:email].nil? or params[:email].blank?
            res[:status] = "-1"  # Bad Request
            render json: res
            return
        end
        dest_user = User.find_by_email(params[:email])
        if dest_user.nil?
            res[:status] = "2"  # No Destination User
            render json: res
            return
        end
        amount = params[:amount].to_i
        if src_user.coins < amount
            res[:status] = "3"  # Insufficient balance
            render json: res
            return
        end
        if amount <= 0
            res[:status] = "4"  # Not a valid amount
            render json: res
            return
        end
        if src_user == dest_user
            res[:status] = "5"  # Source and Destination cannot be same
            render json: res
            return
        end
        t = Transaction.new
        t.user = src_user
        t.receiver = dest_user.email
        t.amount = amount
        src_user.coins -= amount
        dest_user.coins += amount
        src_user.save
        dest_user.save
        t.save
        res[:status] = "0"      # Successful Transaction
        render json: res
    end
end