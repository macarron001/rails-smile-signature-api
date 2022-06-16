Rails.application.routes.draw do
  get '/current_user', to: 'current_user#index'
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
                     controllers: {
                       sessions: 'users/sessions',
                       registrations: 'users/registrations'
                     }

  get '/current_user/staff', to: 'current_user#staff'
  get '/current_user/dentist', to: 'current_user#dentist'
  post '/current_user/create_user/', to: 'current_user#create'
  patch '/current_user/update_user_email/', to: 'current_user#update_email'
  patch '/current_user/update_user_password/', to: 'current_user#update_password'

  post 'appointments/create_appointment/', to: 'appointment#create'
  delete 'appointments/cancel_appointment/', to: 'appointment#cancel'

  post 'records/create_patient_record/', to: 'patient_records#create'
  patch 'records/update_patient_record/', to: 'patient_records#update_record'

  post 'profiles/create_profile/', to: 'profiles#create'
  patch 'profiles/update_profile/', to: 'profiles#edit'
end
