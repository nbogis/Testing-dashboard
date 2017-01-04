class ChangeAttachmentsColumn < ActiveRecord::Migration[5.0]
  def change
    rename_column :attachments, :file_file_name, :attach_file_name
    rename_column :attachments, :file_content_type, :attach_content_type
    rename_column :attachments, :file_file_size, :attach_file_size
  end
end
