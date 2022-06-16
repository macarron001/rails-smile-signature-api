class RenameProfilesColumn < ActiveRecord::Migration[7.0]
  def change
    rename_column :profiles, :sex, :gender
    add_column :profiles, :middle_name, :string
  end
end
