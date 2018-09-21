Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api , defaults: { format: 'json' } do
    get '/register/:token' => 'users#register'
    get '/exists/:token' => 'users#exists'
    get '/coins/:token' => 'users#coins'
    get '/users/:pattern' => 'users#user_list'
    get '/invite_code/:token' => 'users#invite_code'
    post '/transfer/:token' => 'transactions#transfer'
  end

end
