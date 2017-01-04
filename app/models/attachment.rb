class Attachment < ApplicationRecord
  belongs_to :protocol

  has_attached_file :attach

  validates_attachment_content_type :attach, :content_type => ["text/xml", "text/plain","text/html"], :message => 'File must be txt, xml, or html', :size => {less_than: 1.megabytes}

  # create a virtual attribute (setter method) useful to set attribute that don't show in a form
  def attach=(attach)
    # read allows us to process the data and read from it
    self.file_contents = attach.read
    self.attach_file_name = attach.original_filename
    self.attach_content_type = attach.content_type
    self.attach_file_size = attach.size

  end
end
