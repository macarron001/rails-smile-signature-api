class ReplacePatientIdReference < ActiveRecord::Migration[7.0]
  def change
    remove_reference :transactions, :patient_id, null: false, index: true
    add_reference :transactions, :patient, index: true
  end
end
