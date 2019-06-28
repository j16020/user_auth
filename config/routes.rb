Rails.application.routes.draw do
  resources :events
  resources :admin_events
  root 'home#top'
  get 'signup'=>'admin#new'
  get "signin" =>  'session#new'
  get 'mail_user/new' => 'mail_user#new'
  get 'mail_user/show' => 'mail_user#show'
  post 'mail_user/create' => 'mail_user#create'

  get 'user_auth/mailpost' => 'user_auth#mailpost'
  get 'user_auth/new' => 'user_auth#new'
  post 'user_auth/creatuuid' => 'user_auth#create_uuid'
  post 'user_auth/createmail' => 'user_auth#create_mail'
  post 'user_auth/create' => 'user_auth#create'
  post 'user_auth/check' => 'user_auth#check'
  post 'user_auth/forced_create' => 'user_auth#forced_create'
  get 'user_auth/usershow' => 'user_auth#usershow'
  get '/' => "home#top"
  #session
  get    '/login',   to: 'session#new'
  post   '/login',   to: 'session#create'
  delete '/logout',  to: 'session#destroy'

  resources :admin

  #admin_event download
  get 'admin_events/download/:id' => 'admin_events#download'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
