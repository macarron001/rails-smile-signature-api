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

  def set_appointment(date, first_name, last_name, branch, services, dentist_id, time)
    record = Profile.find_by(first_name: first_name, last_name: last_name)

    if record.exists?
      profile = record
    else
      profile = {}
      profile[:first_name] = first_name
      profile[:last_name] = last_name
      profile[:patient_id] = ""
      profile[:mobile] = ""
    end
    
    appointment_params = {}
    appointment_params[:services] = services
    appointment_params[:schedule_date] = date
    appointment_params[:branch] = branch
    appointment_params[:dentist_id] = dentist_id
    appointment_params[:schedule_time] = time
    Appointment.set_appointment(appointment_params, profile)
  end

  def create_record(patient_id, branch, services)
    profile = Profile.find_by(patient_id: patient_id)
    record_params = {}
    record_params[:branch] = branch
    record_params[:services] = services
    PatientRecord.create_record(record_params, profile)
  end

  def is_available?(date, time, dentist_id)
    appointments = Appointment.all.where(
      :schedule_date => date,
      :schedule_time => time,
      :dentist_id => dentist_id
    )
    return true if appointments.blank?
  end
end