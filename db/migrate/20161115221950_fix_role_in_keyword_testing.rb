class FixRoleInKeywordTesting < ActiveRecord::Migration[5.0]
  def change
    rename_column :keyword_testings, :role, :keyword_role
  end
end
