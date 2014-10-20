Rails.application.routes.draw do
  root 'welcome#index'
  resources :pages, only: :show

  namespace :api do
    resources :pages, only: [:create, :show]
  end

  namespace :tpl do
    resources :pages, only: [:index, :show]
  end
end
