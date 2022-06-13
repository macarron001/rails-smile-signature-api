class DatabaseRevision < ActiveRecord::Migration[7.0]
  def change
    remove_reference :appointments, :patient, index: true
    remove_reference :transactions, :patient, index: true

    add_reference :appointments, :user, null: false, foreign_key: true
    add_reference :patient_records, :user, null: false, foreign_key: true

    remove_column :patient_records, :patient_id, :integer
    remove_column :patient_records, :dentist_id, :integer

    add_column :transactions, :first_name, :string, null: false
    add_column :transactions, :last_name, :string, null: false
    
  end
end
