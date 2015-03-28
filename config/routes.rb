Rails.application.routes.draw do

 root 'welcome#index'
 post '/tracks/:track_id/fork', :to => 'tracks#fork'
 get '/tracks.json', :to => 'tracks#json'
 resources :users
 resources :sessions, only: [:new, :create, :destroy]
 resources :categories, only: [:index, :show] do
  resources :tracks, only: [:new, :create]
 end

 resources :courses do
  resources :reviews
end

 resources :tracks, except: [:new, :create] do
   resources :courses, only: [:index, :destroy]
   get '/tracks/:id/done', :to => 'courses#done'
 end


end
