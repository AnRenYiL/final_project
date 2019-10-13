Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get('/', {to: 'users#show', as: 'root'})

  # users controller
  resources :users

  # sessions controller
  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

end
