class AddProfileCheckerToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :profile, :boolean, :default => false
  end
end
