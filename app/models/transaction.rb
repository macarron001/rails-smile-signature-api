class Transaction < ApplicationRecord
  belongs_to :patient_record, optional: true

  validates :services, presence: true
  validates :status, presence: true, :inclusion => { :in => ['full', 'partial', 'follow-up']}
  validates :branch, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :amount, presence: true, numericality: {greater_than: 0}
  validates :remaining, presence: true
  validates :payment_type, presence: true, :inclusion => { :in => ['cash', 'online', 'card']}

  def self.create_transaction(transaction_params, patient_record)
    status = transaction_params[:status]
    transaction = Transaction.create!(
      :first_name => patient_record.first_name,
      :last_name => patient_record.last_name,
      :services => transaction_params[:services],
      :status => status,
      :branch => transaction_params[:branch],
      :amount => transaction_params[:amount],
      :remaining => transaction_params[:remaining],
      :payment_type => transaction_params[:payment_type],
      :patient_record_id => patient_record.id
    )

    if status == 'partial'
      patient_record.set_obligation(transaction)
    elsif status == 'follow-up'
      patient_id.update_obligation(transaction)
    end
  end

  def self.pending?(patient_record_id)
    transactions = Transaction.all.where(
      patient_record_id: patient_record_id,
      status: 'partial'
    )
  end
end
