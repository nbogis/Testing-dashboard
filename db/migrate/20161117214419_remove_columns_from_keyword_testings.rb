class RemoveColumnsFromKeywordTestings < ActiveRecord::Migration[5.0]
  def change
    remove_column :keyword_testings, :test_type,:string
    remove_column :keyword_testings, :test_id, :string
  end
end
