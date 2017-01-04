class CreateTableDocumentation < ActiveRecord::Migration[5.0]
  def change
    create_table :documentations do |t|
      t.text :body
      t.integer :documentable_id
      t.string :documentable_type
    end
    add_index :documentations, [:documentable_id, :documentable_type]
  end
end
