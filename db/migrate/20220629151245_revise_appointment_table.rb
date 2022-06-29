class ReviseAppointmentTable < ActiveRecord::Migration[7.0]
  def change
    remove_column :appointments, :first_name, :string, null: false
    remove_column :appointments, :last_name, :string, null: false
    remove_column :appointments, :dentist_id, :integer
    remove_column :appointments, :services, :json
    add_column :appointments, :full_name, :string, null: false
    add_column :appointments, :email, :string, null: false
  end
end
