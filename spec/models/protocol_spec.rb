require 'rails_helper'

describe Protocol, type: :model do
  let(:protocol) { create(:protocol) }

  it "validates the presence of name" do
    should validate_presence_of(:name)
  end
  ----------------------------------------
 # Associations
 # ----------------------------------------
  context "associations with parent is valid" do
    subject {protocol}

    it "belongs to a product" do
      is_expected.to belong_to(:product)
    end

    it "has one documentation" do
      is_expected.to has_one(:documentation)
    end

    specify "linking a valid product succeeds" do
      product = create(:product)
      protocol.product = product
      expect(protocol).to be_valid
    end

    specify "linking nonexistent product fails" do
      protocol.product_id = 1234
      expect(protocol).not_to be_valid
    end
  end
end
