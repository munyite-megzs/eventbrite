Rails.application.routes.draw do
  devise_for :users

  resources :events

  root 'events#index'

  get 'tags/:tag', to: 'events#index', as: :tag
end
