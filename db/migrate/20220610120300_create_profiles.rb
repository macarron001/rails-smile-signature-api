class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.date :date_of_birth
      t.string :sex
      t.string :mobile
      t.string :address


      t.timestamps
    end
  end
end
