Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

#  root to: 'high_voltage/pages#show', id: 'index'
  mount LetsEncrypt::Engine => '/.well-known'
end
