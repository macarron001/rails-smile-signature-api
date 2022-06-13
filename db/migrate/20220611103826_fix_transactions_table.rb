class FixTransactionsTable < ActiveRecord::Migration[7.0]
  def change
    remove_column :transactions, :patient_id
    add_reference :transactions, :patient_id, index: true
  end
end
