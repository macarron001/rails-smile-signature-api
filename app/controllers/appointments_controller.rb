class AppointmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_user

  def create
    appointment = @user.set_appointment(appointment_params)

    render json: json = {
      status: 201, 
      message: 'Appointment set',
      patient: `#{appointment.first_name} #{appointment.last_name}`
      date: appointment.schedule_date,
      time: appointment.schedule_time,
      branch: appointment.branch
    }
  end

  def cancel
    appointment = Appointment.find_by(
      first_name: params[:first_name],
      last_name: params[:last_name],
      schedule_date: params[:schedule_date],
      schedule_time: params[:schedule_time],
      branch: params[:branch]
    )
    appointment.destroy

    render json: json = {
      status: 201, 
      message: 'Appointment cancelled',
    }, status: :ok
  end


  private

  def appointment_params 
    params.require(:appointment).permit(:branch, :schedule_date, :schedule_time, :first_name, :last_name, :mobile, :services)
  end

  def get_user
    @user = current_user
  end
end
