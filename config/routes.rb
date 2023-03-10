Rails.application.routes.draw do

  namespace :cms do
    resources :pages do
      resources :sections do
        get :select_image
        get :set_image
      end
    end
    resources :images
  end

  get 'pages/:id' , to: 'high_voltage/pages#show', id: 'index'

  #  root to: 'high_voltage/pages#show', id: 'index'
  root to: 'cms#view' , id: 'index'
  get "/:id" ,  to: 'cms#view'
end
