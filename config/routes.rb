Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  
  get "/calendar/:user_id", to: 'calendar#user_calendar'
  post "/calendar/:user_id/available", to: 'calendar#user_available'

  resources :calendar_entries
end
