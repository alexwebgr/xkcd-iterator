Rails.application.routes.draw do
  mount MissionControl::Jobs::Engine, at: "/jobs"

  get 'dashboard/show'
  delete 'dashboard/remove_from_faves/:comic_id', to: 'dashboard#remove_from_faves', as: 'dashboard_remove_from_faves'
  get 'dashboard/activate_subscription/:subscriber_id', to: 'dashboard#activate_subscription', as: 'dashboard_activate_subscription'
  delete 'dashboard/deactivate_subscription/:subscriber_id', to: 'dashboard#deactivate_subscription', as: 'dashboard_deactivate_subscription'

  get 'iterator/show/(:comic_num)', to: 'iterator#show', as: 'iterator_show'
  post 'iterator/add_to_faves/:comic_id', to: 'iterator#add_to_faves', as: 'iterator_add_to_faves'
  delete 'iterator/remove_from_faves/:comic_id', to: 'iterator#remove_from_faves', as: 'iterator_remove_from_faves'
  get 'iterator/update_tree'

  get 'home/who'
  get 'home/subscribe'
  post 'home/do_subscribe'

  post 'auth/google_oauth2'
  get 'auth/google_oauth2/callback' => 'login#google_auth'

  get 'login/show'
  get 'login/validate_user'
  post 'login/send_magic_link'
  delete 'login/destroy'

  resources :email_receipts
  resources :favorites
  resources :comics
  resources :subscriptions
  resources :subscribers

  root 'iterator#show'
end
