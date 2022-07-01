Rails.application.routes.draw do
  get '/current_user', to: 'current_user#index'
  
  get '/staff', to: 'current_user#staff_list'
  get '/dentists', to: 'current_user#dentists'
  post '/current_user/create', to: 'current_user#create'
  patch '/current_user/update_user_password/', to: 'current_user#update_password'
  post '/user/delete', to: 'current_user#delete'
  
  post '/appointments/create/', to: 'appointments#create'
  get '/appointments/:id', to: 'appointments#show'
  patch '/appointments/:id/update', to: 'appointments#update'
  delete '/appointments/:id/cancel/', to: 'appointments#destroy'
  
  get '/patient_records', to: 'patient_records#index'
  post '/patient_records/create', to: 'patient_records#create'
  get '/patient_records/:id', to: 'patient_records#show_record'
  patch '/patient_records/:id/update', to: 'patient_records#update_record'
  
  post '/profile/create', to: 'profiles#create_profile'
  get '/profile/:id', to: 'profiles#show_profile'
  patch '/profiles/update', to: 'profiles#update_profile'

  
  post '/patient_record/:id/transactions/create', to: 'transactions#create_transaction'
  get '/patient_record/:id/transactions', to: 'transactions#patient_transactions'

  get '/transactions/:id', to: 'transactions#show_transaction'
  get '/transactions', to: 'transactions#index'

  post '/services/create', to: 'services#create_service'
  post '/services/delete', to: 'services#delete'
  get '/services', to: 'services#index'
  get '/service', to: 'services#service_details'
  patch '/services/:id', to: 'services#update_service'
  delete '/services/:id', to: 'services#remove_service'

  get '/dental_records', to: 'dental_records#index'
  post '/dental_records/create', to: 'dental_records#create_record'
  get '/dental_records/:id', to: 'dental_records#show_record'
  patch '/dental_records/:id', to: 'dental_records#update_record'

  get '/appointments', to: 'appointments#appointments'
  get '/appointments_today', to: 'appointments#appointments_today'
  get '/appointments_weekly', to: 'appointments#appointments_weekly'
  get '/calendar_events', to: 'appointments#calendar_events'

  #admin
  get '/report_patients', to: 'patient_records#patient_report'
  get '/report_appointments', to: 'appointments#appointment_report'
  get '/report_transactions', to: 'transactions#transaction_report'


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
