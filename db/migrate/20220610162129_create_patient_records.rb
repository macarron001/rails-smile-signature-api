class CreatePatientRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :patient_records do |t|
      t.integer :patient_id
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :branch, null: false
      t.json :services
      t.json :tooth
      t.integer :dentist_id
      t.string :remarks

      t.timestamps
    end
  end
end
