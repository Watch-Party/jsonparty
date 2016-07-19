Rails.application.routes.draw do

  devise_for :users, :controllers => {sessions: 'sessions', registrations: 'registrations'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'home#readme'

  resources :users, only: [:show, :destroy]

  resources :shows, except: [:new, :edit] do
    resources :episodes, except: [:new, :edit], shallow: true do
      resources :posts, except: [:new, :edit], shallow: true
    end
  end
end
