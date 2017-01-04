require 'rails_helper'

describe "products/show.html.erb" do
  let(:product) {create(:product,:name => "product_1", :dhf_num => "123")}

  before(:each) do
    assign(:product, product)
    render
  end

  it "show ptoduct info" do
    expect(rendered).to match("<h1>#{product.name}</h1>")
    expect(rendered).to have_content("DHF #: \n  123\n")
  end

  it "shows edit and delete product links" do
    expect(rendered).to have_selector("a[href=\"#{edit_product_path(product)}\"]")
    expect(rendered).to have_selector("a[href=\"#{product_path(product)}\"]")
  end
end
