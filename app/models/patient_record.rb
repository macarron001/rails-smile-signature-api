class PatientRecord < ApplicationRecord
  belongs_to :user, optional: true

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :dentist_id, presence: true
  validates :services, presence: true
  validates :branch, presence: true
  validates :services, presence: true

  def self.create_record(record_params, profile)
    PatientRecord.create!(
      :patient_id => profile[:user_id],
      :first_name => profile[:first_name],
      :last_name => profile[:last_name],
      :branch => record_params[:branch],
      :tooth => record_params[:tooth],
      :services => record_params[:services],
      :dentist_id => record_params[:dentist_id],
      :remarks => record_params[:remarks]
    )
  end

  def self.edit_record(record_edit_params)
    # key, value, patient_id, dentist_id, date
    schedule = Date.parse(date)
    record = PatientRecord.all.where(
      :patient_id => patient_id,
      :dentist_id => dentist_id,
      :created_at => schedule.beginning_of_day..schedule.end_of_day
    )

    record.update!(key: value)
  end
end
