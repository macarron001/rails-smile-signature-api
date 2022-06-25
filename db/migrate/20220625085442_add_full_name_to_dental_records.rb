class AddFullNameToDentalRecords < ActiveRecord::Migration[7.0]
  def change
    remove_column :dental_records, :first_name, :string, null: false
    remove_column :dental_records, :last_name, :string, null: false
    remove_column :dental_records, :middle_name, :string, null: false
    add_column :dental_records, :full_name, :string, null:false
  end
end
