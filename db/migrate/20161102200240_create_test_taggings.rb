class CreateTestTaggings < ActiveRecord::Migration[5.0]
  def change
    create_table :test_taggings do |t|
      t.references :tag, foreign_key: true
      t.string :tag_role

      t.timestamps
    end
    add_reference :test_taggings, :test_taggable, polymorphic: true, index: true

  end
end
