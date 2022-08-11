# frozen_string_literal: true

Rails.application.routes.draw do
  root 'tests#index'

  get '/about',  to: 'static_pages#about'
  get '/author', to: 'static_pages#author'

  resources :tests do
    resources :questions, shallow: true, except: :index do
      resources :answers, shallow: true, except: :index
    end

    member do
      post :start
    end
  end

  resources :tests_users, only: %i[show update] do
    member do
      get :result
      put :restart
    end
  end
end
