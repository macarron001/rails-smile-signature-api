class Profile < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :date_of_birth, presence: true
  validates :sex, presence: true
  validates :mobile, presence: true
  validates :address, presence: true

  def self.create(profile_params)
    Profile.create!(
      :user_id => profile_params[:user_id],
      :first_name => profile_params[:first_name],
      :last_name => profile_params[:last_name],
      :date_of_birth => profile_params[:date_of_birth],
      :sex => profile_params[:sex],
      :mobile => profile_params[:mobile],
      :address => profile_params[:address]
    )
  end

  def self.edit_profile(key, value, user_id)
    profile = Profile.find_by(user_id: user_id)
    profile.update!(key: value)
  end
  
  def set_obligation(transaction)
    obligation = {}
    obligation[:services] = transaction.services
    obligation[:status] = transaction.status
    obligation[:branch] = transaction.branch
    obligation[:remaining] = transaction.remaining

    self.update!(obligations: obligation)
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
