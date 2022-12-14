class CreateReports < ActiveRecord::Migration[7.0]
  def change
    create_table :reports do |t|
      t.references :user, null: false, foreign_key: true
      t.references :account, null: false, foreign_key: true
      t.integer :points
      t.string :rep_type
      t.integer :rep_count

      t.timestamps
    end
  end
end
