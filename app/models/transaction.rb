class Transaction < ApplicationRecord
  belongs_to :user, optional: true

  validates :patient_id, presence: true
  validates :services, presence: true
  validates :status, presence: true, :inclusion => { :in => ['full', 'partial', 'follow-up']}
  validates :branch, presence: true
  validates :amount, presence: true, numericality: {greater_than: 0}
  validates :remaining, presence: true
  validates :payment_type, presence: true, :inclusion => { :in => ['cash', 'online', 'card']}

  def self.create_transaction(transaction_params)
    patient_id = transaction_params[:patient_id]
    profile = Profile.find_by(user_id: patient_id)
    transaction = Transaction.create!(
      :patient_id => transaction_params[:patient_id],
      :services => transaction_params[:services],
      :status => transaction_params[:status],
      :branch => transaction_params[:branch],
      :amount => transaction_params[:amount],
      :remaining => transaction_params[:remaining],
      :payment_type => transaction_params[:payment_type]
    )

    profile.set_obligation(transaction) if transaction_params[:status] == 'partial'
    profile.update_obligation(patient_id) if transaction_params[:status] == 'follow-up'
  end

  def self.pending?(patient_id)
    transactions = Transaction.all.where(
      patient_id: patient_id,
      status: 'partial'
    )
  end
end
