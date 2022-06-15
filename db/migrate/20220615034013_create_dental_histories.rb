class CreateDentalHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :dental_histories do |t|
      t.string :first_name, null: false
      t.string :middle_name, null: false
      t.string :last_name, null: false
      t.json :services
      t.json :tooth
      t.string :branch
      t.string :remarks
      t.references :patient_record, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
