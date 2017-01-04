require 'rails_helper'

describe Attachment, type: :model do
  let(:protocol) {create(:protocol)}
  let(:attachment) { create(:attachment,:protocol_id => protocol.id)}

  it "belongs to a protocol" do
    is_expected.to belong_to(:protocol)
  end

  specify "linking a valid protocol succeeds" do
    protocol
    attachment.protocol_id = protocol.id
    expect(attachment.protocol).to be_valid
  end

  specify "linking nonexistent protocol fails" do
    attachment
    attachment.protocol_id = 1234
    expect(attachment).not_to be_valid
  end

  it "validates file type" do
    expect(attachment.attach_file_size.to_i).to be <= 1.megabytes
  end

end
