Rails.application.routes.draw do

  namespace :cms do
    resources :image
    resources :page
  end

  get 'pages/:id' , to: 'high_voltage/pages#show', id: 'index'

  #  root to: 'high_voltage/pages#show', id: 'index'
  root to: 'cms#view' , id: 'index'
  get "/:id" ,  to: 'cms#view'
end
