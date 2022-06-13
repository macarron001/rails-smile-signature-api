class RemovePatientIdFromAppointments < ActiveRecord::Migration[7.0]
  def change
    remove_reference :appointments, :patient_id, null: false, index: true
    add_reference :appointments, :patient, index: true
  end
end
