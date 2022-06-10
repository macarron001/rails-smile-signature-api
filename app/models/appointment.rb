class Appointment < ApplicationRecord
  has_many :profiles
  has_many :services

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :schedule_date, presence: true
  validates :schedule_time, presence: true
  validates :branch, presence: true
  validates :services, presence: true

  def self.set_appointment(appointment_params, profile)
    Appointment.create!(
      :patient_id => profile.user_id
      :first_name => profile.first_name
      :last_name => profile.last_name
      :mobile => profile.mobile
      :type => appointment_params[:type]
      :branch => appointment_params[:branch]
      :services => appointment_params[:services]
      :dentist_id => appointment_params[:dentist_id]
      :schedule_date => appointment_params[:schedule_date]
      :schedule_time => appointment_params[:schedule_time]
    )
  end
end