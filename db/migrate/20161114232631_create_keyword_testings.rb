class CreateKeywordTestings < ActiveRecord::Migration[5.0]
  def change
    create_table :keyword_testings do |t|
      t.integer :keyword_id
      t.string :role
      t.string :test_type
      t.integer :test_id

      t.timestamps
    end
    add_reference :keyword_testings, :keywordable, polymorphic: true, index: true

  end
end
