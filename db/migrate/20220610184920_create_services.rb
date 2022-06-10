class CreateServices < ActiveRecord::Migration[7.0]
  def change
    create_table :services do |t|
      t.string :name, null: false
      t.decimal :price, precision: 8, scale: 2
      t.string :branch
      
      t.timestamps
    end
  end
end
