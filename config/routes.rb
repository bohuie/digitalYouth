Rails.application.routes.draw do
  get 'settings/consent'

  get 'settings/privacy'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount Searchjoy::Engine, at: "/admin/searchjoy"
  get 'welcome/index'
  get 'signup_jobseeker' => 'welcome#signup_jobseeker'
  get 'signup_employer' => 'welcome#signup_employer'
  get 'welcome/signup_jobseeker' => 'welcome#signup_jobseeker'
  get 'welcome/signup_employer' => 'welcome#signup_employer'

  # Consent
  get 'consent/business_consent/:id' => 'consent#business_consent', as: :business_consent
  get 'consent/adult_consent/:id' => 'consent#adult_consent', as: :adult_consent
  post 'consent/create' => 'consent#create'
  patch 'consent/update/:id' => 'consent#update'

  # Searches
  get 'search' => 'searches#index'
  get 'search/:id' => 'searches#navigate', as: :search_nav

  # Notifications
  # Analytics
  get 'analytics' => 'analytics#index'
  get 'analytics/:id' => 'analytics#show', as: :analytics_report

  #Omniauth, different
  #match '/auth/:provider/callback' to: 'users/sessions#create', via: [:get, :post]
  #match '/logout', to: 'users/sessions#destroy', via: [:get, :post]

  #notifications
  get 'notifications' => 'notifications#index'
  get 'notifications/show' => 'notifications#show', as: :show_notifications
  get 'notifications/:id' => 'notifications#trackable', as: :show_trackable
  patch 'notifications' => 'notifications#update'
  patch 'notifications/all' => 'notifications#update_all', as: :update_all_notifications
  delete 'notifications' => 'notifications#delete'
  delete 'notifications/all' => 'notifications#delete_all', as: :delete_all_notifications
  get 'users/referenceTab' => 'users#reference_tab'

  # Devise_for :users
  devise_for :users, controllers: { passwords: "users/passwords", sessions: "users/sessions", :registrations => "users/registrations", omniauth_callbacks: 'users/omniauth_callbacks' }
  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup

  post 'users/home_tab' => 'users#home_tab'
  post 'users/nav_tab' => 'users#nav_tab'

 #devise_for :users
  #resources :users, only: :show, as: :user
  get '/users/:id/crop' => 'users#crop'
  get '/users/:id' => 'users#show', as: :user
  get '/users/:id/edit' => 'users#edit', as: :edit_user
  patch '/users/:id' => 'users#update'
  get 'users/:id/contact' => 'users#contact', as: :contact_user
  post 'users/:id/contact' => 'users#send_mail', as: :email_user


  # Skill routes
  #get '/skills/:id' => 'skills#show', as: :skill
  #get '/skills/:id/edit' => 'skills#edit', as: :edit_skill
  patch 'skills/:id' => 'skills#update'
  post 'skills' => 'skills#create'
  get 'skills/autocomplete' => 'skills#autocomplete'


  # User-skill routes
  get '/user_skills/:id/edit' => 'user_skills#edit', as: :edit_user_skill
  get '/user_skills/edit_all' => 'user_skills#edit_all', as: :edit_all_user_skill
  patch '/user_skills/update_all' => 'user_skills#update_all', as: :update_all_user_skill
  patch '/user_skills/:id' => 'user_skills#update'
  delete '/user_skills/:id' => 'user_skills#destroy', as: :delete_user_skill
  post '/user_skills' => 'user_skills#create'

  # Job Posting routes
  #get 'job_postings' => 'job_postings#index'
  get 'job_postings' => 'job_postings#index'
  get 'job_postings/new' => 'job_postings#new', as: :new_job_posting
  get 'job_postings/refresh' => 'job_postings#refresh', as: :refresh_job_posting
  post 'job_postings/refresh' => 'job_postings#refresh_process', as: :refresh_job_posting_process
  get 'job_postings/:id' => 'job_postings#show', as: :job_posting
  get 'job_postings/:id/edit' => 'job_postings#edit', as: :edit_job_posting
  patch 'job_postings/:id' => 'job_postings#update'
  delete 'job_postings/:id' => 'job_postings#destroy'
  post 'job_postings' => 'job_postings#create'
  get 'job_postings/:id/compare' => 'job_postings#compare', as: :compare_applications

  # Job Posting Application routes
  get 'job_posting_applications/new' => 'job_posting_applications#new', as: :new_job_posting_application
  get 'job_posting_application/:id' => 'job_posting_applications#show', as: :job_posting_application
  post 'job_posting_applications' => 'job_posting_applications#create'
  patch 'job_posting_applications/:id' => 'job_posting_applications#update', as: :update_job_posting_application
  delete 'job_posting_application/:id' => 'job_posting_applications#destroy'

  # Project routes
  get 'projects/new' => 'projects#new', as: :new_project
  get 'projects/:id' => 'projects#show', as: :project
  get 'projects/:id/edit' => 'projects#edit', as: :edit_project
  patch 'projects/:id' => 'projects#update'
  post 'projects' => 'projects#create'
  delete 'projects/:id' => 'projects#destroy', as: :delete_project


  # Project skill routes
 # get 'project_skills/:id' => 'project_skills#show', as: :project_skill
  #get 'project_skills/:id/edit' => 'project_skills#edit', as: :edit_project_skill
  patch 'project_skills/:id' => 'project_skills#update'
  post 'project_skills' => 'project_skills#create'

  # Reference routes
  get 'references/refer' => 'references#email', as: :email_reference
  get 'references/new/:id' => 'references#new', as: :new_reference
  post 'references/refer' => 'references#send_mail', as: :reference_emails
  post 'references' => 'references#create'
  patch 'references/:id' => 'references#update', as: :update_reference
  delete 'references/:id' => 'references#destroy', as: :delete_reference

  delete 'reference_redirections/:id' => 'reference_redirections#destroy', as: :delete_reference_redirection

  # Survey routes
  get 'surveys/:title/compare' => 'surveys#compare', as: :compare_survey
  get 'surveys/:title/compare_to' => 'surveys#compare_to', as: :survey_compare_to
  get 'surveys/compare_all' => 'surveys#compare_all', as: :survey_compare_all
  get 'surveys' => 'surveys#index'
  get 'surveys/:title' => 'surveys#show', as: :survey
  get 'surveys/:title/edit' => 'surveys#edit', as: :edit_survey
  post 'responses' => 'responses#create'
  patch 'responses' => 'responses#update'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  get 'about_us' => 'welcome#about_us', as: :about_us
  get 'lost_email' => 'welcome#lost_email', as: :lost_email
  post 'lost_email' => 'welcome#send_lost_email', as: :send_lost_email
  get 'contact_us' => 'welcome#contact_us', as: :contact_us
  post 'contact_us' => 'welcome#send_contact_us', as: :send_contact_us
  root 'welcome#index'

  get '*path' => redirect('/')

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
