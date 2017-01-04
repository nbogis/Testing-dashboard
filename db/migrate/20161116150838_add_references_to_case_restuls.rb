class AddReferencesToCaseRestuls < ActiveRecord::Migration[5.0]
  def change
    add_reference :case_results, :testcase, foreign_key: true
  end
end
