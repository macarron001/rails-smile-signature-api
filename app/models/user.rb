class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  has_one :profile
  has_many :appointments
  has_many :patient_records
  has_many :transactions

  validates :email, uniqueness: true
  validates :password, presence: true
  validates :role, :inclusion => { :in => ['staff', 'dentist', 'admin']}

  
  devise :database_authenticatable, :registerable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self, :authentication_keys => [:username]

  def create_profile(profile_params)
    Profile.create(profile_params)
  end

  def set_appointment(appointment_params)
    id = self.id
    Appointment.set_appointment(appointment_params, id)
  end

  def create_record(record_params)
    id = self.id
    PatientRecord.create_record(record_params, id)
  end

  def is_available?(date, time, id)
    appointments = Appointment.all.where(
      :schedule_date => date,
      :schedule_time => time,
      :user_id => id
    )
    return true if appointments.blank?
  end

  def create_service(service_params)
    Service.create_service(service_params)
  end
end