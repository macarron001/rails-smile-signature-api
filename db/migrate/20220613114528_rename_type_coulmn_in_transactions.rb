class RenameTypeCoulmnInTransactions < ActiveRecord::Migration[7.0]
  def change
    remove_column :transactions, :type, :string
    add_column :transactions, :payment_type, :string
  end
end
