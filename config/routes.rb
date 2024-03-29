# frozen_string_literal: true

Rails.application.routes.draw do
  root 'tests#index'

  devise_for :users, path: :gurus,
                     controllers: { sessions: 'users/sessions' },
                     path_names: { sign_in: :login, sign_out: :logout }

  devise_scope :user do
    get 'gurus/:id/profile', to: 'users/registrations#profile', as: :profile
  end

  resources :tests, only: :index do
    member do
      post :start
    end
  end

  resources :tests_users, only: %i[show update] do
    member do
      get :result
      put :restart
      post :gist
    end
  end

  resources :gists, only: :create

  namespace :admin do
    resources :tests do
      resources :questions, shallow: true, except: :index do
        resources :answers, shallow: true, except: :index
      end
    end
    resources :gists, only: :index
  end
end
