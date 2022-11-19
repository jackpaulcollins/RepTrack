class CreateMetrics < ActiveRecord::Migration[7.0]
  def change
    create_table :metrics do |t|
      t.references :product, null: false, foreign_key: true
      t.string :name, null: false
      t.string :unit_of_measurement, null: false
      t.string :timeframe, null: false

      t.timestamps
    end
  end
end
