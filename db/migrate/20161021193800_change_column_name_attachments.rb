class ChangeColumnNameAttachments < ActiveRecord::Migration[5.0]
  def change
    rename_column :attachments, :attachment_file_name, :file_file_name
    rename_column :attachments, :attachment_content_type, :file_content_type
    rename_column :attachments, :attachment_file_size, :file_file_size
  end
end
