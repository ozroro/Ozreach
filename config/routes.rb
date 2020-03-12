Rails.application.routes.draw do
  concern :profile do
    get 'profile', on: :member
  end

  namespace :recruiter do
    resources :users, except: [:index, :new], concerns: :profile do
      get 'articles', on: :member
    end
    resources :articles, except: [:index, :show]
    resources :applicants, only: [:index, :show, :update, :destroy]

    # get 'signup' => 'users#new'
  end

  namespace :seeker do
    resources :users, except: [:index, :new], concerns: :profile
    # get 'signup' => 'users#new'
    resources :applicants, only: [:index, :destroy]
    get 'recruiters' => 'users#recruiters'
  end

  # post  'appllcant/:article_id' => 'seeker/applicant#create'
  resource :profile, only: [:edit, :show, :update]
  resources :articles, only: [:show, :index]
  post '/applying/:article_id' => 'seeker/applicants#create', as: :applying

  root 'static_pages#top'

  get '/home' => 'home#home_selector'

  get  '/help' => 'static_pages#help'
  get  '/about' => 'static_pages#about'
  get  '/contact' => 'static_pages#contact'
  get '/signup' => 'users#new'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
