Rails.application.routes.draw do
  
  namespace :user do
    resources :seekers, except: :index
    resources :recruiters, except: :index 
  end
  get '/seeker_signup' => 'user/seeker#new'
  get '/recruiter_signup' => 'user/recruiters#new'
  

  resources :articles
  
  
  root 'static_pages#home'
  
  get  '/help' => 'static_pages#help'
  get  '/about' => 'static_pages#about'
  get  '/contact' => 'static_pages#contact'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
