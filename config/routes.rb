Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
resources :scales, only: [:index]
get '/scales/:scale_slug/:root_note', to: 'scales#show'

resources :users, only: [:new]

get '/login', to: 'session#new'



root 'welcome#welcome'

end
