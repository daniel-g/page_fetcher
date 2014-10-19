Rails.application.routes.draw do
  root 'welcome#index'
  resources :pages, only: :show

  namespace :api do
    resources :pages, only: :create
  end
end
