class PatientRecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_user
  before_action :get_patient_record, only: [:update_record, :show_record]

  def create
    record = @user.create_record(patient_record_params)

    render json: json = {
      status: 201, 
      message: 'Patient record created!',
      record: record,
    }, status: :ok
  end

  def show_record
    render json: @patient_record
  end

  def update_record
    @patient_record.update(patient_record_params)

    render json: json = {
      status: 201,
      message: 'Patient record updated!',
      record: @patient_record,
    }, status: :ok
  end

  private

  def patient_record_params 
    params.require(:patient_record).permit(:first_name, :last_name, :middle_name, :gender, :date_of_birth, :mobile, :email, :street_address, :barangay, :city)
  end

  def get_patient_record
    @patient_record = PatientRecord.find(params[:id])
  end

  def get_user
    @user = current_user
  end
end
