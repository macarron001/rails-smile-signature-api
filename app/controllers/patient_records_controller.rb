class PatientRecordsController < ApplicationController
  # before_action :authenticate_user!, except: [:index, :create, :patient_report]
  # before_action :get_user
  # before_action :get_patient_record, only: [:update_record, :show_record]

  def index
    records = PatientRecord.all

    render json: records
  end

  def create
    # record = @user.create_record(patient_record_params)
    record = PatientRecord.create(patient_record_params)

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

  def patient_report
    report = PatientRecord.patient_report()

    render json: report
  end

  def obligations
    records = PatientRecord.get_obligations

    render json: records
  end

  private

  def patient_record_params 
    params.require(:patient_record).permit(:full_name, :gender, :date_of_birth, :mobile, :email, :address)
  end

  def get_patient_record
    @patient_record = PatientRecord.find(params[:id])
  end

  def get_user
    @user = current_user
  end
end
