class AddFullNameToTransactions < ActiveRecord::Migration[7.0]
  def change
    remove_column :transactions, :first_name, :string, null: false
    remove_column :transactions, :last_name, :string, null: false
    add_column :transactions, :full_name, :string, null:false
  end
end
