Rails.application.routes.draw do
  root 'welcome#index'

  namespace :api do
    resources :pages, only: [:create, :show, :index]
  end

  namespace :tpl do
    resources :pages, only: :show
  end
end
