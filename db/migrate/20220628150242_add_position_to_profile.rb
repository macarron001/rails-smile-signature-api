class AddPositionToProfile < ActiveRecord::Migration[7.0]
  def change
    add_column :profiles, :position, :string
  end
end
