Rails.application.routes.draw do
  devise_for :admins#, skip: :registration
  mount_devise_token_auth_for 'User', at: 'auth'

  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'

  # resources :feeds

  # devise_for :users, :controllers => {sessions: 'sessions', registrations: 'registrations'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'home#readme'

  require 'sidekiq/web'
  Sidekiq::Web.instance_variable_get(:@middleware).delete_if { |klass,_,_| klass == Rack::Protection }
  Sidekiq::Web.set :protection, except: :content_security_policy
  Sidekiq::Web.set :session_secret, Rails.application.secrets[:secret_key_base]
  mount Sidekiq::Web => '/sidekiq'

  resources :users, only: [:show, :destroy]
  # resources :watches, only: [:create, :destroy]

  # resources :shows, except: [:new, :edit] do
  #   resources :episodes, except: [:new, :edit], shallow: true do
  #     resources :posts, except: [:new, :edit], shallow: true
  #   end
  # end
  get '/admins/admin/:id' => 'admins#show'
  get '/admins/show/new' => 'admins/shows#new'
  get '/admins/show/comfirm' => 'admins/shows#confirm'
  post '/admins/show/:tvrage_id' => 'admins/shows#create'

  get '/party/:episode_id' => 'episodes#new_party'
  get  '/:showname/:season/:episode/posts' => 'posts#index'
  get '/:showname/:season/:episode/' => 'episodes#get_id'
  get '/:showname/info' => 'shows#info'
  get '/:showname/new' => 'shows#new'
  post '/:tvrage_id/confirm' => 'shows#create'
  post '/watch/:id/' => 'watches#create'
  delete '/watch/:id/' => 'watches#destroy'
  get '/search/init' => 'search#init'
  get '/search/users' => 'search#users'
  get '/search/shows' => 'search#shows'
  get '/upcoming' => 'episodes#upcoming'
  get '/recent' => 'shows#recent'

end
