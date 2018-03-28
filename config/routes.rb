Rails.application.routes.draw do
  root to: 'read_laters#index'

  get 'read_laters', to: 'read_laters#index'

  post 'read_laters/push', to: 'read_laters#push'
  post 'read_laters/bulk_push', to: 'read_laters#bulk_push'

  get 'read_laters/pop', to: 'read_laters#pop'

  get 'login', to: 'email_authenticate#index'
  post 'login', to: 'email_authenticate#create'
  delete 'logout', to: 'email_authenticate#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
