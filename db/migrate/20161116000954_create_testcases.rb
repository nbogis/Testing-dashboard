class CreateTestcases < ActiveRecord::Migration[5.0]
  def change
    create_table :testcases do |t|
      t.string :name
      t.references :testsuite, foreign_key: true
      t.timestamps
    end
  end
end
