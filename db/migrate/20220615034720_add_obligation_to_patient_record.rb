class AddObligationToPatientRecord < ActiveRecord::Migration[7.0]
  def change
    add_column :patient_records, :obligation, :json
    remove_column :profiles, :obligations, :json
  end
end
