class AddColumnsToTables < ActiveRecord::Migration[5.0]
  def change
    add_column :testsuites, :test_template, :string
    add_column :testsuites, :test_timeout, :time
    add_column :testsuites, :source, :string
    add_column :testsuites, :library, :string

    add_column :testcases, :execution_time, :time
    add_column :testcases, :template, :string
    add_column :testcases, :timeout, :time
  end
end
