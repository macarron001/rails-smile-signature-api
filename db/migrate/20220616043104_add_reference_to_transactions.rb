class AddReferenceToTransactions < ActiveRecord::Migration[7.0]
  def change
    add_reference :transactions, :patient_record, foreign_key: true
  end
end
