class PatientRecord < ApplicationRecord
  belongs_to :user, optional: true
  has_many :dental_records

  validates :first_name, presence: true
  validates :middle_name, presence: true
  validates :last_name, presence: true
  validates :gender, presence: true
  validates :date_of_birth, presence: true
  validates :mobile, presence: true


  def self.create_record(record_params)
    PatientRecord.create!(
      :first_name => record_params[:first_name],
      :middle_name => record_params[:middle_name],
      :last_name => record_params[:last_name],
      :gender => record_params[:gender],
      :date_of_birth => record_params[:date_of_birth],
      :mobile => record_params[:mobile],
      :street_address => record_params[:street_address],
      :barangay => record_params[:barangay],
      :city => record_params[:city]
    )
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
    if obligation.remaining == transaction.amount
      obligation = nil
    else
      remaining = obligation.remaining - transaction.amount
      obligation.update!(remaining: remaining)
    end
  end
end
