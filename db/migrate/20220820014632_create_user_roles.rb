class CreateUserRoles < ActiveRecord::Migration[7.0]
  def change
    create_table :user_roles do |t|
      t.references :product, null: false, foreign_key: true
      t.string :name, null: false

      t.timestamps
    end
  end
end
