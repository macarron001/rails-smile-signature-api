class ReviseServicesTable < ActiveRecord::Migration[7.0]
  def change
    remove_column :services, :price, :decimal
    remove_column :services, :branch, :string
  end
end
