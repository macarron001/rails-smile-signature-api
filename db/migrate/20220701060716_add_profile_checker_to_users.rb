class AddProfileCheckerToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :has_profile, :boolean, :default => false
  end
end
