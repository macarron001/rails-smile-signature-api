class TransactionsController < ApplicationController
  # before_action :authenticate_user!
  before_action :get_patient_record, except: [:index, :show_transaction]
  # before_action :get_transaction, only: [:show_transaction]

  def index
    transactions = Transaction.all
    render json: transactions
  end

  def create_transaction
    transaction = current_user.create_transaction(transaction_params, @patient_record)

    if transaction
      if transaction_params[:status] == 'full'
        render json: json = {
          status: 201, 
          message: 'Payment Success!',
          transaction: transaction[0],
        }, status: :ok
      else
        render json: json = {
          status: 201, 
          message: 'Payment Success!',
          transaction: transaction[0],
          profile: transaction[1]
        }, status: :ok
      end
    else
      render json: json = {
        status: 400,
        error: 'Transaction not processed',
        message: 'Patient has outstanding obligation'
      }, status: :ok
    end
  end

  def patient_transactions
    transactions = @patient_record.transactions
    render json: transactions
  end

  def show_transaction
    render json: @transaction
  end

  def transaction_report
    report = Transaction.transaction_report

    render json: report
  end

  private
  def transaction_params 
    params.require(:transaction).permit(:services, :status, :branch, :amount, :remaining, :payment_type)
  end

  def get_transaction
    @transaction = Transaction.find(params[:id])
  end

  def get_patient_record
    @patient_record = PatientRecord.find(params[:id])
  end
end
