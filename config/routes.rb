Rails.application.routes.draw do

 root 'welcome#index'
 resources :users
 resources :sessions, only: [:new, :create, :destroy]
 resources :categories, only: [:index, :show]
 resources :courses do
  resources :reviews
end

 resources :tracks

end
