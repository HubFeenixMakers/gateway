Rails.application.routes.draw do

  get 'pages/:id' , to: 'high_voltage/pages#show', id: 'index'

  #  root to: 'high_voltage/pages#show', id: 'index'
  root to: 'cms#view' , id: 'index'
  get "/:id" ,  to: 'cms#view'
end
