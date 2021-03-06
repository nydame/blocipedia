Rails.application.routes.draw do
  # get 'wikis/index'
  # get 'wikis/show'
  # get 'wikis/new'
  # get 'wikis/edit'
  resources :wikis
  devise_for :users, controllers: {registrations: 'users/registrations'}
  resources :charges, only: [:new, :create]
  resources :collaborations, only: [:create, :destroy]
  # get 'welcome/index'
  root 'welcome#index' #same as root({to: 'welcome#index'})
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
