Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api , defaults: { format: 'json' } do
    post '/register/:token' => 'users#register'
    get '/exists/:token' => 'users#exists'
    get '/coins/:token' => 'users#coins'
    get '/users/:pattern' => 'users#user_list'
    post '/transfer/:token' => 'transactions#transfer'
  end

end
