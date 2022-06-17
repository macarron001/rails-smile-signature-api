class Transaction < ApplicationRecord
  belongs_to :patient_record

  validates :services, presence: true
  validates :status, presence: true, :inclusion => { :in => ['full', 'partial', 'follow-up']}
  validates :branch, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :amount, presence: true, numericality: {greater_than: 0}
  validates :remaining, presence: true
  validates :payment_type, presence: true, :inclusion => { :in => ['cash', 'online', 'card']}

  def self.create_transaction(transaction_params, patient_record, id)
    patient_record_id = patient_record.id
    status = transaction_params[:status]

    if status == 'partial'
      return if patient_record.has_obligation?
    end

    transaction = Transaction.create!(
      :first_name => patient_record.first_name,
      :last_name => patient_record.last_name,
      :services => transaction_params[:services],
      :status => status,
      :branch => transaction_params[:branch],
      :amount => transaction_params[:amount],
      :remaining => transaction_params[:remaining],
      :payment_type => transaction_params[:payment_type],
      :patient_record_id => patient_record.id,
      :user_id => id
    )

    transaction.is_partial?(status, transaction)
    transaction.is_follow_up?(status, transaction)

    transaction = {}
    transaction[:amount] = transaction_params[:amount]
    transaction[:status] = transaction_params[:status]
    transaction[:payment_type] = transaction_params[:payment_type]

    record = {}
    record[:obligation] = PatientRecord.find(patient_record_id).obligation

    return transaction, record
  end

  def self.pending?(patient_record_id)
    transactions = Transaction.all.where(
      patient_record_id: patient_record_id,
      status: 'partial'
    )
  end

  def is_partial?(status, transaction)
    patient_record.set_obligation(transaction) if status == 'partial'
  end

  def is_follow_up?(status, transaction)
    patient_record.update_obligation(transaction) if status == 'follow-up'
  end
end
