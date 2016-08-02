Rails.application.routes.draw do
  devise_for :admins#, skip: :registration
  mount_devise_token_auth_for 'User', at: 'auth'

  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'

  #github style markdown for homepage
  root 'home#readme'

  #sidekiq sinatra page (with work arounds for current incompatibility)
  require 'sidekiq/web'
  Sidekiq::Web.instance_variable_get(:@middleware).delete_if { |klass,_,_| klass == Rack::Protection }
  Sidekiq::Web.set :protection, except: :content_security_policy
  Sidekiq::Web.set :session_secret, Rails.application.secrets[:secret_key_base]
  mount Sidekiq::Web => '/sidekiq'


  #routes for admin site
  get '/admins/admin/:id' => 'admins#show'
  get '/admins/show/new' => 'admins/shows#new'
  get '/admins/show/comfirm' => 'admins/shows#confirm'
  post '/admins/show/:tvrage_id' => 'admins/shows#create'
  get '/admins/show/:id/edit' => 'admins/shows#edit'
  patch '/admins/show/:id/update' => 'admins/shows#update'
  patch '/admins/show/:id/deactivate' => 'admins/shows#deactivate'
  patch '/admins/show/:id/activate' => 'admins/shows#activate'
  get '/admins/shows' => 'admins/shows#index'

  #routes for spoileralert api
  resources :users, only: [:show]
  get '/party/:episode_id' => 'episodes#new_party'
  get  '/:showname/:season/:episode/posts' => 'posts#index'
  get '/:showname/:season/:episode/' => 'episodes#get_id'
  get '/:showname/info' => 'shows#info'
  post '/watch/:id/' => 'watches#create'
  delete '/watch/:id/' => 'watches#destroy'
  get '/search/init' => 'search#init'
  get '/search/users' => 'search#users'
  get '/search/shows' => 'search#shows'
  get '/episodes/:id' => 'episodes#info'
  get '/upcoming' => 'episodes#upcoming'
  get '/recent' => 'shows#recent_for_user'
  # get '/search' => 'search#search'  currently not in use

end
