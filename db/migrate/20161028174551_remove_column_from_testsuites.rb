class RemoveColumnFromTestsuites < ActiveRecord::Migration[5.0]
  def change
    remove_column :testsuites, :product_id, :string
  end
end
