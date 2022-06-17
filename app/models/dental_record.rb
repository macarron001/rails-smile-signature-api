class DentalRecord < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :patient_record, optional: true  

  alias_attribute :dentist_id, :user_id

  validates :first_name, presence: true
  validates :middle_name, presence: true
  validates :last_name, presence: true
  validates :services, presence: true
  validates :tooth, presence: true
  validates :branch, presence: true

  def self.create_record(dental_record_params)
    record = DentalRecord.create!(
      :first_name => dental_record_params[:first_name],
      :middle_name => dental_record_params[:middle_name],
      :last_name => dental_record_params[:last_name],
      :services => dental_record_params[:services],
      :tooth => dental_record_params[:tooth],
      :branch => dental_record_params[:branch],
      :remarks => dental_record_params[:remarks],
      :dentist_id => dental_record_params[:dentist_id],
      :patient_record_id => dental_record_params[:patient_record_id]
    )
  end
end
