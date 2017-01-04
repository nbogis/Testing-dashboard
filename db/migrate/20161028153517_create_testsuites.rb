class CreateTestsuites < ActiveRecord::Migration[5.0]
  def change
    create_table :testsuites do |t|
      t.string :name
      t.references :product, foreign_key: true
      t.timestamps
    end
  end
end
