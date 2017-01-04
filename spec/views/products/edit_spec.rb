require 'rails_helper'

describe "products/edit.html.erb" do
  before do
    product = create(:product,:name => "product_1", :dhf_num => "123")
    assign(:product, product)
    render
  end
  it "show header" do
    # render the template in the describe
    expect(rendered).to match('<h1>Edit a new product</h1>')
  end

  context "show edit form" do
    it "shows product name field with stored value" do
      expect(rendered).to have_selector("form") do |form|
        expect(form).to have_selector("label", :text => "Product name")
        expect(form).to have_selector("input", :type => "text", :name => "name", :value => "product_1")
      end
    end

    it "shows DHF number field with stored value" do
      expect(rendered).to have_selector("form") do |form|
        expect(form).to have_selector("label", :text => "DHF #")
        expect(form).to have_selector("input", :type => "text", :name => "dhf_num", :value => "123")
      end
    end

    it "shows submit button" do
      expect(rendered).to have_selector("form") do |form|
        expect(form).to have_selector("input", :type => "submit")
      end
    end
  end

end
