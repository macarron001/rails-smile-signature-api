class FixUserTable < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :username, :string
    add_column :users, :email, :string, null: false
    add_column :users, :username, :string, null: false, unique: true
  end
end
