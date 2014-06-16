Bloccit::Application.routes.draw do
  devise_for :users
  # resources :users, only: [:update]
  resources :users, only: [:show, :index, :update]

  resources :topics do
    resources :posts, except: [:index], controller: 'topics/posts' do
      resources :comments, only: [:create]
    #, except: [:index]
    end
  end
  get 'about' => 'welcome#about'
  root to: 'welcome#index'
end
