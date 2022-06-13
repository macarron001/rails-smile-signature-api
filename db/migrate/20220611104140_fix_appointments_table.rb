class FixAppointmentsTable < ActiveRecord::Migration[7.0]
  def change
    remove_column :appointments, :patient_id
    add_reference :appointments, :patient_id, index: true
  end
end
