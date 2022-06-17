Rails.application.routes.draw do
  get '/current_user', to: 'current_user#index'
  
  get '/current_user/staff', to: 'current_user#staff'
  get '/current_user/dentist', to: 'current_user#dentist'
  post '/current_user/create', to: 'current_user#create'
  patch '/current_user/update_user_password/', to: 'current_user#update_password'
  
  post '/appointments/create/', to: 'appointments#create'
  get '/appointments/:id', to: 'appointments#show'
  patch '/appointments/:id/update', to: 'appointments#update'
  delete '/appointments/:id/cancel/', to: 'appointments#destroy'
  
  post '/patient_records/create', to: 'patient_records#create'
  get '/patient_records/:id', to: 'patient_records#show_record'
  patch '/patient_records/:id/update', to: 'patient_records#update_record'
  
  post '/profiles/create', to: 'profiles#create_profile'
  get '/profile', to: 'profiles#show_profile'
  patch '/profiles/update', to: 'profiles#update_profile'

  post '/patient_records/:id/transactions/create', to: 'transactions#create_transaction'
  get '/patient_records/:id/transactions', to: 'transactions#patient_transactions'
  get '/transactions/:id', to: 'transactions#show_transaction'
  get '/transactions', to: 'transactions#index'

  post '/services/create', to: 'services#create_service'
  get '/services', to: 'services#index'
  get '/service', to: 'services#service_details'
  patch '/services/:id', to: 'services#update_service'
  delete '/services/:id', to: 'services#remove_service'

  post '/dental_records/create', to: 'dental_records#create_record'
  get '/dental_records/:id', to: 'dental_records#show_record'
  patch '/dental_records/:id', to: 'dental_records#update_record'


  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
end
