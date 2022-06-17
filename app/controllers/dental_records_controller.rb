class DentalRecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_dentist!
  before_action :get_dental_record, except: [:create_record]

  def create_record
    record = current_user.create_dental_record(dental_record_params)

    render json: json = {
      status: 201,
      message: 'Dental record created!',
      record: record,
    }, status: :ok
  end

  def show_record
    render json: @dental_record
  end

  def update_record
    if @dental_record.update(dental_record_params)
      render json: json = {
        status: 201,
        message: 'Dental record updated!',
        record: @dental_record,
      }, status: :ok
    else
      render json: @dental_record.errors, status: :unprocessable_entity
    end
  end

  private

  def dental_record_params 
    params.require(:dental_record).permit(:first_name, :last_name, :middle_name, :services, :tooth, :branch, :remarks, :dentist_id, :patient_record_id)
  end

  def authenticate_dentist!
  render json: json = {
    status: 401, 
    message: 'Unauthorized user.',
  }, status: :unauthorized unless current_user.role == 'dentist'
  end

  def get_dental_record
    @dental_record = DentalRecord.find(params[:id])
  end
end
