class Appointment < ApplicationRecord
  belongs_to :user

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :schedule_date, presence: true
  validates :schedule_time, presence: true
  validates :branch, presence: true
  validates :services, presence: true

  def self.set_appointment(appointment_params, id)
    date = appointment_params[:schedule_date]
    time = appointment_params[:schedule_time]
    branch = appointment_params[:branch]

    if Appointment.schedule_available?(date, time, branch)
      Appointment.create!(
        :user_id => id,
        :branch => branch,
        :schedule_date => date,
        :schedule_time => time,
        :first_name => appointment_params[:first_name],
        :last_name => appointment_params[:last_name],
        :mobile => appointment_params[:mobile],
        :services => appointment_params[:services]
      )
    end
  end

  def self.schedule_available?(date, time, branch)
    appointments = Appointment.all.where(
      :schedule_date => date,
      :schedule_time => time,
      :branch => branch
    )

    return true if appointments.blank?
  end
end