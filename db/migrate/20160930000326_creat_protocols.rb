class CreatProtocols < ActiveRecord::Migration[5.0]
  def change
    create_table :protocols do |t|
      t.string :name
      t.references :product, foreign_key: true
      t.string :revision
      t.timestamps
    end
  end
end
