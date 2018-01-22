Rails.application.routes.draw do

  mount_devise_token_auth_for 'Owner', at: 'auth'

  resources :clubs do
    resources :members do
      resources :checkins
      collection do
        get :checked_in_today
        post :lookup
      end
    end
    resources :checkins, :except => [:create]
  end

  get '/ping', to: 'application#ping'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
