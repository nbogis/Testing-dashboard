class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :dhf_num
      t.string :executor_id

      t.timestamps
    end
  end
end
