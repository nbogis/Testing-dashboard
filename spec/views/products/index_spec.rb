require 'rails_helper'

describe "products/index.html.erb" do
  let(:product) { create(:product) }

  it "shows all registered products" do
    products = [product, create(:product)]

    #actually setting the instance variable === @prouducts = products but more rspec-like
    assign(:products,products)

    # render the template in the describe
    render

    expect(rendered).to match('<h1>Sentinel Products</h1>')

    products.each do |prod|
      expect(rendered).to have_selector("a[href=\"#{product_path(prod)}\"]", :text => prod.name)
    end
  end

  it "shows a link to add new product" do
    products = [product, create(:product)]
    assign(:products,products)
    render
    expect(rendered).to have_link('Add a new product',:href => "#{new_product_path}")
  end
end
