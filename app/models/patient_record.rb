class PatientRecord < ApplicationRecord
  belongs_to :user

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :user_id, presence: true
  validates :services, presence: true
  validates :branch, presence: true

  def self.create_record(record_params, id)
    PatientRecord.create!(
      :first_name => record_params[:first_name],
      :last_name => record_params[:last_name],
      :branch => record_params[:branch],
      :tooth => record_params[:tooth],
      :services => record_params[:services],
      :remarks => record_params[:remarks],
      :user_id => id
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
