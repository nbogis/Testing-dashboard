FactoryGirl.define do
  factory :attachment do
    attach_file_name {"output.xml"}
    attach_content_type {"text/xml"}
    attach_file_size {"227"}
    # attach File.new(Rails.root + 'spec/factories/files/output.xml')
  end
end
