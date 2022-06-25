class CombineFirstAndLastName < ActiveRecord::Migration[7.0]
  def change
    remove_column :patient_records, :first_name, :string, null: false
    remove_column :patient_records, :last_name, :string, null: false
    remove_column :patient_records, :middle_name, :string
    remove_column :patient_records, :street_address, :string
    remove_column :patient_records, :barangay, :string
    remove_column :patient_records, :city, :string
    add_column :patient_records, :full_name, :string, null:false
    add_column :patient_records, :address, :string, null:false
  end
end
