class DentalRecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_dentist!
  before_action :get_dental_record, except: [:create_record]

  def create_record
    record = @dentist.create_dental_record(dental_record_params)

    render json: json = {
      status: 201,
      message: `Record updated!`,
      record: record,
    }, status: :ok
  end

  def show_record
    render json: @record
  end

  def update_record
    if @record.update(post_params)
      render json: json = {
        status: 201,
        message: `Dental record updated!`,
        record: record,
      }, status: :ok
    else
      render json: @record.errors, status: :unprocessable_entity
    end
  end

  private

  def dental_record_params 
    params.require(:dental_record).permit(:first_name, :last_name, :middle_name, :services, :tooth, :branch, :remarks)
  end

  def authenticate_dentist!
  render json: json = {
    status: 401, 
    message: 'Unauthorized user.',
  }, status: :unauthorized unless current_user.role == 'dentist'
  end

  def get_dental_record
    @record = DentalRecord.find(params[:id])
  end

  def get_dentist
    @dentist = current_user
  end
end
