class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  has_one :profile
  has_many :appointments
  has_many :patient_records
  has_many :transactions
  has_many :dental_records

  validates :email, presence: true
  validates :password, presence: true

  
  devise :database_authenticatable, :registerable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: self

  def create_profile(profile_params)
    id = self.id
    Profile.create(profile_params, id)
  end

  def set_appointment(appointment_params)
    id = self.id
    Appointment.set_appointment(appointment_params, id)
  end

  def create_record(record_params)
    PatientRecord.create_record(record_params)
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

  def remove_service(service_name)
    service = Service.find_by(name: service_name)
    service.destroy
  end

  def create_dental_record(dental_record_params)
    DentalRecord.create_record(dental_record_params)
  end

  def create_transaction(transaction_params, patient_record)
    id = self.id
    Transaction.create_transaction(transaction_params, patient_record, id)
  end
end