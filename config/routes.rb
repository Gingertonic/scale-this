Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

# Scales routes
resources :scales, only: [:index, :new, :create, :update, :destroy]
get '/scales/most_popular', to: 'scales#most_popular', as: 'most_popular_scale'
get '/scales/:scale_slug', to: 'scales#show'
get '/scales/:scale_slug/edit', to: 'scales#edit', as: 'edit_scale'
post '/scales/:scale_slug/change_root', to: 'scales#change_root'
get '/scales/:scale_slug/:root_note', to: 'scales#show', as: 'show_scale'

resources :notes, only: [:index]

resources :practises, only: [:create]

#helper routes
get '/current_username', to: 'application#current_username'

# Sessions routes
get '/login', to: 'sessions#new', as: 'login'
get '/auth/:provider/callback', to: 'sessions#create' # OAuth callback route
post '/login', to: 'sessions#create'
get '/logout', to: 'sessions#destroy'

# Users (musicians) routes
resources :musicians, only: [:new, :create]
get '/musicians/rankings/:by', to: 'musicians#rankings', as: 'musician_rankings'
get '/musicians/:id/practise_log', to: 'musicians#practise_log'
get '/:musician_slug', to: 'musicians#show', as: 'practice_room'

root 'welcome#welcome'


end
