class User < ApplicationRecord
    has_many :transactions
    validates_uniqueness_of :email, :invite_code
    validates_presence_of :token 
end
