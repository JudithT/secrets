Rails.application.routes.draw do
  get '/users' => 'users#index'
  get '/show' => 'users#show'
  get 'users/:id' =>'users#show'
  post '/create' => 'users#create'
  post '/login' => 'users#login'
  post '/secret' => 'users#postsecret'
  get '/secrets' => 'users#secrets'
  post'/like/:id' => 'users#like'
  post '/delete/:id' => 'users#delete'
  post'/like:id' => 'users#like'
  post'/unlike:id' => 'users#unlike'
  post'/like:id' => 'users#like'
  get 'logout'  => 'users#logout'
  



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
