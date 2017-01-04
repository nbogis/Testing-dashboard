class CreateAttachments < ActiveRecord::Migration[5.0]
  def change
    create_table :attachments do |t|
      t.string :attachment_file_name
      t.string :attachment_content_type
      t.string :attachment_file_size
      t.binary :file_contents
      t.references :protocol, foreign_key: true

      t.timestamps
    end
  end
end
