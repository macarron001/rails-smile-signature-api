class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  has_one :profile
  has_many :appointments
  has_many :patient_records
  has_many :transactions

  validates :email, uniqueness: true
  validates :password, presence: true
  validates :role, :inclusion => { :in => ['patient', 'dentist', 'admin']}

  
  devise :database_authenticatable, :registerable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self, :authentication_keys => [:username]


  def create_profile(profile_params)
    Profile.create(profile_params)
  end

  def set_appointment(first_name, last_name, appointment_params)
    record = Profile.find_by(first_name: first_name, last_name: last_name)

    if record.present?
      profile = record
    else
      profile = {}
      profile[:first_name] = first_name
      profile[:last_name] = last_name
      profile[:patient_id] = ""
      profile[:mobile] = ""
    end
    
    Appointment.set_appointment(appointment_params, profile)
  end

  def create_record(id, record_params)
    profile = Profile.find_by(user_id: id)
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

  def create_service(service_params)
    Service.create_service(service_params)
  end
end