class CreateAppointments < ActiveRecord::Migration[7.0]
  def change
    create_table :appointments do |t|
      t.date :schedule_date, null: false
      t.integer :patient_id
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :mobile
      t.string :type
      t.string :branch
      t.json :services
      t.integer :dentist_id
      t.time :schedule_time


      t.timestamps
    end
  end
end
