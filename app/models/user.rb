class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  has_many :appointments, through: :profile
  has_many :patient_records, through: :profile
  has_many :transactions

  validates :username, presence: true, uniqueness: true, length: {minimum: 6}
  validates :password, presence: true
  validates :role, :inclusion => { :in => ['patient', 'dentist', 'admin']}

  devise :database_authenticatable, :registerable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self


  def create_profile(user_id, first_name, last_name, date_of_birth, sex, mobile, address)
    profile_params = {}
    profile_params[:user_id] = user_id
    profile_params[:first_name] = first_name
    profile_params[:last_name] = last_name
    profile_params[:date_of_birth] = date_of_birth
    profile_params[:sex] = sex
    profile_params[:mobile] = mobile
    profile_params[:address] = address
    Profile.create_new(profile_params)
  end

  def set_appointment(schedule, patient_id, branch, services, dentist_id, time)
    profile = Profile.find_by(patient_id: patient_id)
    appointment_params = {}
    appointment_params[:schedule] = schedule
    appointment_params[:branch] = branch
    appointment_params[:dentist_id] = dentist_id
    appointment_params[:time] = time
    Appointment.set_appointment(appointment_params, profile)
  end

  def create_record(patient_id, branch, services)
    profile = Profile.find_by(patient_id: patient_id)
    record_params = {}
    record_params[:branch] = branch
    record_params[:services] = services
    PatientRecord.create_record(record_params, profile)
  end
end