Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/sleeps/friends', to: 'sleeps#list_friends'

  post '/sleeps', to: 'sleeps#create'
  post '/users/friends/:friend_id', to: 'users#follow'

  delete '/users/friends/:friend_id', to: 'users#unfollow'
end