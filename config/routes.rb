Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'

  resources :feeds

  # devise_for :users, :controllers => {sessions: 'sessions', registrations: 'registrations'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'home#readme'

  resources :users, only: [:show, :destroy]
  # resources :watches, only: [:create, :destroy]

  # resources :shows, except: [:new, :edit] do
  #   resources :episodes, except: [:new, :edit], shallow: true do
  #     resources :posts, except: [:new, :edit], shallow: true
  #   end
  # end

  get  '/:showname/:season/:episode/posts' => 'posts#index'
  post '/:showname/:season/:episode/posts' => 'posts#create'
  get '/:showname/new' => 'shows#new'
  post '/:tvrage_id/confirm' => 'shows#create'
  post '/users/:id/watched' => 'watched#create'
  delete '/users/:id/watched' => 'watched#destroy'
  patch '/posts/:id/pop' => 'posts#pop'
end
