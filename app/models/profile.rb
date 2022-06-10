class Profile < ApplicationRecord
  belongs_to :user
  belongs_to :transaction
  belongs_to :appointment
  belongs_to :patient_record

  validates :user_id, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :date_of_birth, presence: true
  validates :sex, presence: true

  def self.create(profile_params)
    Profile.create!(
      :user_id => profile_params[:user_id]
      :first_name => profile_params[:first_name]
      :last_name => profile_params[:last_name]
      :date_of_birth => profile_params[:first_name]
      :sex => profile_params[:sex]
      :mobile => profile_params[:mobile]
      :address => profile_params[:address]
    )
  end

  def self.edit_profile(key, value, user_id)
    profile = Profile.find_by(user_id: user_id)
    profile.update!(key: value)
  end
  
  def set_obligations(patient_id)
    pending_transactions = Transaction.pending?(patient_id)
    obligations = []
    pending_transactions.each do |transaction|
      obligation = {}
      obligation[:status] = transaction.status,
      obligation[:branch] = transaction.branch,
      obligation[:services] = transaction.services,
      obligation[:remaining] = transaction.remaining,
      obligations << obligation
    end

    self.update!(obligations: obligations)
    return obligations
  end

  def update_obligation(transaction)
    obligation = self.obligations.where(
      services: services,
      branch: branch
    )
    if obligation.remaining == transaction.amount
      obligation.destroy
    else
      remaining = obligation.remaining - transaction.amount
      obligation.update!(remaining: remaining)
    end
  end
end
