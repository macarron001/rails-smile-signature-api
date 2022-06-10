class Transaction < ApplicationRecord
  has_one :profile
  has_many :services

  validates :patient_id, presence: true
  validates :services, presence: true
  validates :status, presence: true :inclusion => { :in => ['full', 'partial', 'follow-up']}
  validates :branch, presence: true
  validates :amount, presence: true, numericality: {greater_than: 0}
  validates :remaining, presence: true
  validates :type, presence: true, :inclusion => { :in => ['cash', 'online', 'card']}

  def self.create_transaction(transaction_params)
    patient_id = transaction_params[:patient_id]
    profile = Profile.find_by(user_id: patient_id)
    Transaction.create!(
      :patient_id => transaction_params[:patient_id],
      :services => transaction_params[:services],
      :status => transaction_params[:status],
      :branch => transaction_params[:branch],
      :amount => transaction_params[:amount],
      :remaining => transaction_params[:remaining],
      :type => transaction_params[:type]
    )

    profile.set_obligations(patient_id) if transaction_params[:status] == 'partial'
    profile.update_obligation(patient_id) if transaction_params[:status] == 'follow-up'
  end

  def self.pending?(patient_id)
    transactions = Transaction.all.where(
      patient_id: patient_id,
      status: 'partial'
    )
  end
end
