Rails.application.routes.draw do
  root 'welcome#index'
  resources :pages, only: :show
end
