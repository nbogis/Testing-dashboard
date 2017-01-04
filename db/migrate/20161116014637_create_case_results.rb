class CreateCaseResults < ActiveRecord::Migration[5.0]
  def change
    create_table :case_results do |t|
      t.string :result

      t.timestamps
    end
  end
end
