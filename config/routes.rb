Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

# Scales routes
resources :scales, only: [:index]
get '/scales/:scale_slug/:root_note', to: 'scales#show', as: 'scale'
post '/scales/:scale_slug', to: 'scales#change_root'

# Users (musicians) routes
resources :users, only: [:new]

# Sessions routes
get '/login', to: 'sessions#new', as: 'login'
get '/auth/:provider/callback', to: 'sessions#create'
post '/login', to: 'sessions#create'
get '/logout', to: 'sessions#destroy'



root 'welcome#welcome'

end
