Rails.application.routes.draw do

  concern :profile do
    get 'profile', on: :member
  end

  namespace :recruiter do
    resources :users, except: :index, concerns: :profile do
      get 'articles', on: :member
    end
    resources :articles
    get 'signup' => 'users#new'
  end

  namespace :seeker do
    resources :users, except: :index, concerns: :profile
    get 'signup' => 'users#new'
    resources :applicants, only: [:index, :new, :create, :destroy]

  end


  resource :profile, only: [:edit, :show, :update]
    
  root 'static_pages#top'
  
  get '/home' => 'home#home_selector'
  
  get  '/help' => 'static_pages#help'
  get  '/about' => 'static_pages#about'
  get  '/contact' => 'static_pages#contact'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
