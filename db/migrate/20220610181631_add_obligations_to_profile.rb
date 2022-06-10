class AddObligationsToProfile < ActiveRecord::Migration[7.0]
  def change
    add_column :profiles, :obligations, :json
  end
end