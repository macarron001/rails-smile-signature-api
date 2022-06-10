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
    date = appointment_params[:schedule_date]
    time = appointment_params[:schedule_time]
    branch = appointment_params[:branch]

    if schedule_available?(date, time, branch)
      Appointment.create!(
        :branch => branch
        :schedule_date => date
        :schedule_time => time
        :patient_id => profile[:user_id]
        :first_name => profile[:first_name]
        :last_name => profile[:last_name]
        :mobile => profile[:mobile]
        :type => appointment_params[:type]
        :services => appointment_params[:services]
        :dentist_id => appointment_params[:dentist_id]
      )
  end

  def schedule_available?(date, time, branch)
    appointments = Appointment.all.where(
      :schedule_date => date,
      :schedule_time => time,
      :branch => branch
    )

    return true if appointments.blank?
  end
end