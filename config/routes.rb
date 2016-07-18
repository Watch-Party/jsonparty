Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:show, :destroy]

  resources :shows, except: [:new, :edit] do
    resources :episodes, except: [:new, :edit], shallow: true
  end
end
