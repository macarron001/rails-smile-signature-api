class DentalRecordsController < ApplicationController
  # before_action :authenticate_user!, except: [:index, :create_record]
  # before_action :authenticate_dentist!
  # before_action :get_dental_record, except: [:index, :create_record]

  def index
    records = DentalRecord.all
    render json: records
  end

  def create_record
    # record = current_user.create_dental_record(dental_record_params)
    record = DentalRecord.create(dental_record_params)

    render json: json = {
      status: 201,
      message: 'Dental record created!',
      record: record,
    }, status: :ok
  end

  def show_records
    id = params[:id]
    records = DentalRecord.where(patient_record_id: id)
    
    render json: records
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
    params.require(:dental_record).permit(:full_name, :services, :tooth, :branch, :remarks, :dentist_id, :patient_record_id)
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
