Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get('/', {to: 'users#show', as: 'root'})

  get('/users/getUserByUserName', to: 'users#getUserByUserName')
  # users controller
  resources :users
  resources :requests, only: [:create, :update]
  # sessions controller
  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end
  resources :chanels do
    resources :messages
    
  end
  get('/messages/getMoreMsg', to: 'messages#getMoreMsg')
  # mount ActionCable.server => '/cable'
end
