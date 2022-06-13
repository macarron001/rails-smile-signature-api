class RemoveTypeFromAppointments < ActiveRecord::Migration[7.0]
  def change
    remove_column :appointments, :type, :string
  end
end
