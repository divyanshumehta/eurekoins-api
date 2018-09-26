Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/api/register/:token' => 'users#register'
  get '/api/exists/:token' => 'users#exists'
  get '/api/coins/:token' => 'users#coins'
  get '/api/users/:pattern' => 'users#user_list'
  get '/api/invite_code/:token' => 'users#invite_code'
  get '/api/transfer/:token' => 'transactions#transfer'
  get '/api/coupon/:token' => 'coupons#avail_coupon'
end
