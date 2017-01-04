Rails.application.routes.draw do
  devise_for :users
  get 'products/index'

  root 'products#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :products do
    resources :protocols do
      # resources :documentations,only: [:show, :new,:edit, :update], :defaults => {:documentable => 'protocols'}
      resources :attachments, :only => [:create, :new, :destroy,:show] do
        member do
          # since serve is not a restfull route, it need to be under it's resource
          get "serve_inline"
        end
        member do
          get "serve_attach"
        end
      end
      resources :testsuites do
        resources :testcases, :only => [:show]
      end
    end
  end

 # resources :documentations, only: [:index]
end
