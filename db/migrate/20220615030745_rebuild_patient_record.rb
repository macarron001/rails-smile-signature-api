class RebuildPatientRecord < ActiveRecord::Migration[7.0]
  def change
    remove_reference :patient_records, :user, null: false, foreign_key: true

    remove_column :patient_records, :branch, :string, null: false
    remove_column :patient_records, :services, :json
    remove_column :patient_records, :tooth, :json
    remove_column :patient_records, :remarks, :string
    add_column :patient_records, :middle_name, :string
    add_column :patient_records, :gender, :string
    add_column :patient_records, :date_of_birth, :string
    add_column :patient_records, :mobile, :string
    add_column :patient_records, :email, :string
    add_column :patient_records, :street_address, :string
    add_column :patient_records, :barangay, :string
    add_column :patient_records, :city, :string
  end
end
