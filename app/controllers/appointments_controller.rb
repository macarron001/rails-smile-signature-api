class AppointmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_user
  before_action :get_appointment, except: [:create]

  def create
    appointment = @user.set_appointment(appointment_params)

    render json: json = {
      status: 201, 
      message: 'Appointment set',
      appointment: appointment
    }
  end

  def show
    appointment = Appointment.find(params[:id])
    render json: appointment
  end

  def update
    if @appointment.update(appointment_params)
      render json: json = {
        status: 201,
        message: 'Dental appointment updated!',
        appointment: @appointment,
      }, status: :ok
    else
      render json: @appointment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @appointment.destroy
      render json: json = {
        status: 201,
        message: "Appointment cancelled!",
        appointment: @appointment,
      }, status: :ok
    else
      render json: @appointment.errors, status: :unprocessable_entity
    end
  end


  private

  def appointment_params 
    params.require(:appointment).permit(:branch, :schedule_date, :schedule_time, :first_name, :last_name, :mobile, :services)
  end

  def get_appointment
    @appointment = Appointment.find(params[:id])
  end

  def get_user
    @user = current_user
  end
end
