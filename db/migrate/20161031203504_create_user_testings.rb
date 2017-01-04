class CreateUserTestings < ActiveRecord::Migration[5.0]
  def change
    create_table :user_testings do |t|
      t.references :user, foreign_key: true
      t.string :user_role
      t.timestamps
    end
    add_reference :user_testings, :user_testable, polymorphic: true, index: true
  end
end
