Rails.application.routes.draw do
  # require 'sidekiq/web'
  # mount Sidekiq::Web => '/sidekiq'

  get 'dashboard/show'
  delete 'dashboard/remove_from_faves/:favorite_id', to: 'dashboard#remove_from_faves', as: 'dashboard_remove_from_faves'
  get 'dashboard/activate_subscription/:subscriber_id', to: 'dashboard#activate_subscription', as: 'dashboard_activate_subscription'
  delete 'dashboard/deactivate_subscription/:subscriber_id', to: 'dashboard#deactivate_subscription', as: 'dashboard_deactivate_subscription'

  get 'iterator/show/(:comic_num)', to: 'iterator#show', as: 'iterator_show'
  get 'iterator/add_to_faves/:comic_num', to: 'iterator#add_to_faves', as: 'iterator_add_to_faves'
  delete 'iterator/remove_from_faves/:favorite_id', to: 'iterator#remove_from_faves', as: 'iterator_remove_from_faves'
  get 'iterator/update_tree'
  get 'iterator/send_email'

  get 'home/who'
  get 'home/subscribe'
  post 'home/do_subscribe'

  get 'auth/google_oauth2'
  get 'auth/google_oauth2/callback' => 'login#google_auth'

  get 'login/show'
  get 'login/validate_user'
  post 'login/send_magic_link'
  delete 'login/destroy'

  resources :email_receipts do
    collection do
      get 'populate_receipts'
    end
  end

  resources :favorites
  resources :comics
  resources :subscriptions
  resources :subscribers

  root 'iterator#show'
end
