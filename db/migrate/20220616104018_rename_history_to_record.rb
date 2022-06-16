class RenameHistoryToRecord < ActiveRecord::Migration[7.0]
  def change
    rename_table :dental_histories, :dental_records
  end
end
