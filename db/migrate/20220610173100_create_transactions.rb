class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.integer :patient_id
      t.json :services
      t.string :status
      t.string :branch, null: false
      t.decimal :amount, precision: 8, scale: 2
      t.decimal :remaining, precision: 8, scale: 2
      t.string :type

      t.timestamps
    end
  end
end
