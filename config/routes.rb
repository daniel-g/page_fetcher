Rails.application.routes.draw do
  root 'welcome#index'
  get '/templates/*id' => 'templates#show', as: :template

  namespace :api do
    resources :pages, only: [:create, :show, :index]
  end
end
