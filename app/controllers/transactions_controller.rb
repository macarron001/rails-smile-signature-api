class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_patient_record

  def create_transaction
    Transaction.create_transaction(transaction_params, @patient_record)

    render json: json = {
      status: 201, 
      message: `Transaction created!`,
      transaction: transaction,
    }, status: :ok
  end

  private
  def transaction_params 
    params.require(:transaction).permit(:services, :status, :branch, :amount, :remaining, :payment_type)
  end

  def get_patient_record
    @patient_record = PatientRecord.find(params[:idd])
  end
end
