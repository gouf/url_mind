Rails.application.routes.draw do
  get 'read_laters', to: 'read_laters#index'

  post 'read_laters/push', to: 'read_laters#push'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
