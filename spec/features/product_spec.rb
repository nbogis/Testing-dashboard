require 'rails_helper'

feature 'Product' do
  let(:product) { create(name: "Capybara 1")}

  before do
    visit root_path
  end

  scenario { expect(page).to have_content "Sentinel Products" }

  scenario "add a new product" do
    click_link "Add a new product"

    fill_in "product[name]", with: "Product capybara"
    fill_in "product[dhf_num]", with: "V_capybara"

    expect{ click_button "Submit" }.to change(Product,:count).by(1)
  end

end
