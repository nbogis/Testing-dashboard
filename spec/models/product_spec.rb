require 'rails_helper'

describe Product, :type => :model do
  let(:product) {build(:product)}

  it "with a valid name" do
    expect(product).to be_valid
  end

  it "without a name is invalid" do
    new_product = build(:product, name: nil)
    expect(new_product).not_to be_valid
  end


  context "product attribute validations reject unwanted entries" do
    subject {product}

    it "validates presence of name" do
      should validate_presence_of(:name)
    end

    it "validates uniqueness of name" do
      is_expected.to validate_uniqueness_of(:name)
    end
  end

  it "saves with with no errors" do
    expect{product.save!}.not_to raise_error
  end

  context "when saving multiple products" do
    before do
      product.save!
    end

    it "doesn't allow identical products" do
      new_product = build(:product, :name => product.name)
      expect(new_product).not_to be_valid
    end
  end

# ----------------------------------------
# Associations
# ----------------------------------------
context "associations with children are valid" do
  subject {product}
  let(:protocol) {create(:protocol)}

  it "has many protocols" do
    is_expected.to have_many(:protocols).dependent(:destroy)
  end

end



end
