require 'rails_helper'

feature 'protocol' do
  let(:product) { create(:product)}
  let(:protocol) {create(:protocol, :product_id => product.id)}
  let(:attachment) { create(:attachment,:protocol_id => protocol.id)}

  before do
    product
    protocol
  end

  it "create a new protocol with attachement" do
    visit product_protocol_path(product,protocol)

    attach_file('Attach', "#{Rails.root}/spec/factories/files/output.xml")

    attachment.reload
    find("#uplaod_button").click
    expect(Attachment.last.attach_file_name).to eq "output.xml"
  end

  it "displays flash when attaching a file with wrong type",:focus => true do
    visit product_protocol_path(product,protocol)

    attach_file('Attach', "#{Rails.root}/spec/factories/files/Data Test Log.pdf")

    attachment.reload
    find("#uplaod_button").click
    expect(Attachment.last.attach_file_name).to_not eq "Data Test Log.pdf"
    expect(page).to have_content("Something went wrong!! Make sure to select a txt, html, or xml file")
  end

  it "create a new protocol with documentation" do
    visit new_product_protocol_path(product,protocol)

    fill_in "Name", with: "protocol_1"
    fill_in "Documentation", with: "protocol_documentation"

    click_button 'Submit'

    expect(Documentation.last.body).to eq("protocol_documentation")
  end

end
