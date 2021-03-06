Rails.application.routes.draw do
  get 'welcome/index'

  get 'password_resets/new'
  get 'password_resets/edit'
  get 'sessions/new'

  get 'static_pages/about'
  get 'static_pages/terms'
  get 'static_pages/privacy'

  get 'microposts/survey'

  get 'users/new'
  get 'users/admins'
# get 'users/enthusiasts'
# get 'users/skeptics'
# get 'users/pioneers'
# get 'users/navigators'
# get 'users/coachs'
# get 'users/solos'

  get 'companies/index'
  get 'companies/show'
  get 'companies/new'

  get 'positions/new'
  get 'positions/index'
  get 'positions/show'

  get 'allies/index'
  get 'allies/show'
  get 'allies/new'


  get 'employments/new'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'
  get 'home' => 'welcome#index'
  get 'about' => 'static_pages#about'
  get 'terms' => 'static_pages#terms'
  get 'privacy' => 'static_pages#privacy'
 
  # User Authenticaitons
  get 'signup'  => 'users#new'
  get 'survey' => 'microposts#survey'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  get '/auth/:provider/callback', to: 'sessions#create_linkedin'

  get 'companies' => 'companies#index'
  get 'companies/:id/show' => 'companies#show'

  get 'positions' => 'positions#index'
  get 'positions/:id/edit' => 'positions#edit'
  
  get 'allies' => 'allies#index'
  get 'allies/:id/show' => 'allies#show'

 # get 'enthusiasts' => 'users#enthusiasts'
 # get 'skeptics' => 'users#skeptics'
 # get 'pioneers' => 'users#pioneers'
 # get 'navigators' => 'users#navigators'
 # get 'coaches' => 'users#coachs'
 # get 'solos' => 'users#solos'
 # get 'users/coaches' => 'users#coachs'


  get 'users/:id/setting' => 'users#setting', as: :setting
  get 'users/:id/summary' => 'users#summary', as: :summary
#  get 'users/:id/allies' => 'users#allies', as: :allies
  get 'users/:id/skills' => 'users#skills', as: :skills
  get 'users/:id/avatar' => 'users#avatar', as: :avatar

  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :microposts, only: [:index, :create, :edit, :update, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :positions, only: [:create, :edit, :update, :destroy]
  resources :companies
  resources :employments
  resources :allies
  
  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
