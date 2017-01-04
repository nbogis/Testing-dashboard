class AddColumnToTestsuites < ActiveRecord::Migration[5.0]
  def change
    add_reference :testsuites, :protocol, foreign_key: true
  end
end
