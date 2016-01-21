Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  namespace :admin do
    resources :badges, :users, :teams
  end



  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  root to: "home#index"
  devise_for :users, controllers: {registrations: 'registrations'}
  resources :teams, except: [:destroy]
  resources :cycles, only: [:show, :index, :destroy]
  resources :year_plans
  resources :plans, only: [:show, :destroy]


  get 'team/sort/:id', to: 'teams#sort_by', as: :sort_by
  get 'user/archive/:id', to: 'users#archive', as: :archive
  get 'team/archive/:id', to: 'teams#archive', as: :team_archive
  get 'user/unarchive/:id', to: 'users#unarchive', as: :unarchive
  post 'user/move_to_archive/:id', to: 'users#finish_archiving', as: :archive_scout

  get 'meetings/sum_up/:id', to: 'meetings#sum_up', as: :sum_up_meeting
  patch 'plans/finish_up/:id', to: 'plans#finish_up', as: :finish_meeting_up

  get 'plans/new/:id', to: 'plans#new', as: :new_plan
  get 'plans/edit/:id', to: 'plans#edit', as: :edit_plan
  post 'plans/create/:id', to: 'plans#create', as: :create_plan
  patch 'plans/update/:id', to: 'plans#update', as: :update_plan
  delete 'plans/delete/:id', to: 'plans#destroy', as: :destroy_plan

  get 'team/add_scout/:id', to: 'teams#add_scout', as: :add_scout
  post 'team/create_scout/:id', to: 'teams#create_scout', as: :create_scout
  get 'team/edit_scout/:id', to: 'teams#edit_scout', as: :team_edit_scout
  patch 'team/update_scout/:id', to: 'teams#update_scout', as: :team_update_scout

  get 'team/add_team_group/:id', to: 'teams#add_team_group', as: :add_team_group
  post 'team/create_team_group/:id', to: 'teams#create_team_group', as: :create_team_group
  get 'team/edit_team_group/:id', to: 'teams#edit_team_group', as: :edit_team_group
  patch 'team/update_team_group/:id', to: 'teams#update_team_group', as: :update_team_group
  delete 'team/team_group/:id', to: 'teams#delete_team_group', as: :delete_team_group

  get 'scouts/edit/:id', to: 'users#edit_scout', as: :edit_scout
  get 'meetings/edit/:id', to: 'meetings#edit', as: :edit_meeting
  get 'meetings/new/:id', to: 'meetings#new', as: :new_meeting
  post 'meetings/create/:id', to: 'meetings#create', as: :create_meeting
  patch 'meetings/update/:id', to: 'meetings#update', as: :update_meeting

  get 'cycles/edit/:id', to: 'cycles#edit', as: :edit_cycle
  get 'cycles/new/:id', to: 'cycles#new', as: :new_cycle
  post 'cycles/create/:id', to: 'cycles#create', as: :create_cycle
  patch 'cycles/update/:id', to: 'cycles#update', as: :update_cycle

  get 'users/start_next_trial/:id/', to: 'users#start_trial', as: 'user_start_trial'
  get 'users/edit_trial/:id/', to: 'users#edit_trial', as: 'edit_trial'
  patch '/users/trial/:id/update', to: 'users#update_trial', as: :update_trial
  get '/users/trial/:id/manage', to: 'users#manage_trial', as: :manage_trial
  patch '/users/trial/:id/progress', to: 'users#progress_trial', as: :progress_trial
  get '/users/trial/:id', to: 'users#show_trial', as: :show_trial
  get '/users/finish_trial/:id', to: 'users#finish_trial', as: :finish_trial
  patch '/rank_requirements/update_badges/:id', to: 'rank_requirements#update_badges', as: :update_badges
  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

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
