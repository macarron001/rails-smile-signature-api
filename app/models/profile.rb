class Profile < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :date_of_birth, presence: true
  validates :gender, presence: true
  validates :mobile, presence: true
  validates :address, presence: true

  def self.create(profile_params)
    Profile.create!(
      :user_id => profile_params[:id],
      :first_name => profile_params[:first_name],
      :middle_name => profile_params[:middle_name],
      :last_name => profile_params[:last_name],
      :date_of_birth => profile_params[:date_of_birth],
      :gender => profile_params[:gender],
      :mobile => profile_params[:mobile],
      :address => profile_params[:address]
    )
  end

  def self.edit_profile(key, value, user_id)
    profile = Profile.find_by(user_id: user_id)
    profile.update!(key: value)
  end
  
end
