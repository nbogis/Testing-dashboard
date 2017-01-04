require 'rails_helper'

describe "products/new.html.erb" do
  before do
    # use build since new doesn't push data to db
    product = build(:product)
    assign(:product, product)
    render
  end
  it "show header" do
    # render the template in the describe
    expect(rendered).to match('<h1>Add a new product</h1>')
  end

  context "show new form" do
    it "shows product name field with stored value" do
      expect(rendered).to have_selector("form") do |form|
        expect(form).to have_selector("label", :text => "Product name")
        expect(form).to have_selector("input", :type => "text", :name => "name")
      end
    end

    it "shows DHF number field with stored value" do
      expect(rendered).to have_selector("form") do |form|
        expect(form).to have_selector("label", :text => "DHF #")
        expect(form).to have_selector("input", :type => "text", :name => "dhf_num")
      end
    end

    it "shows submit button" do
      expect(rendered).to have_selector("form") do |form|
        expect(form).to have_selector("input", :type => "submit")
      end
    end
  end

end
