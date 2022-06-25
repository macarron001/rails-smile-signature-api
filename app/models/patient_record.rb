class PatientRecord < ApplicationRecord
  belongs_to :user, optional: true
  has_many :dental_records
  has_many :transactions

  validates :full_name, presence: true
  validates :gender, presence: true
  validates :date_of_birth, presence: true
  validates :mobile, presence: true


  def self.create_record(record_params)
    PatientRecord.create!(
      :full_name => record_params[:full_name],
      :gender => record_params[:gender],
      :date_of_birth => record_params[:date_of_birth],
      :mobile => record_params[:mobile],
      :email => record_params[:email],
      :address => record_params[:address]
    )
  end

  def has_obligation?
    if self.obligation != nil
      return true
    else
      return false
    end
  end

  def set_obligation(transaction)
    obligation = {}
    obligation[:services] = transaction.services
    obligation[:status] = transaction.status
    obligation[:branch] = transaction.branch
    obligation[:remaining] = transaction.remaining

    self.update!(obligation: obligation)
  end

  def update_obligation(transaction)
    obligation = self.obligation
    remaining = obligation['remaining'].to_i
    if remaining == transaction.amount
      self.update!(obligation: nil)
    else
      remaining_balance = remaining - transaction.amount
      obligation.update!(remaining: remaining_balance)
    end
  end
end
