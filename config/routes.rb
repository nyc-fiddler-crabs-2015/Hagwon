Rails.application.routes.draw do

 root 'welcome#index'
 get '/tracks.json', :to => 'tracks#json'
 resources :users
 resources :sessions, only: [:new, :create, :destroy]
 resources :categories, only: [:index, :show] do
  resources :tracks, only: [:new, :create]
 end

 resources :courses do
  resources :reviews
  post '/check', :to => 'courses#check'
  post '/uncheck', :to => 'courses#uncheck'
end

 resources :tracks, except: [:new, :create] do
   resources :courses, only: [:index, :destroy]
   post '/follow', :to => 'tracks#follow'
 end


end
