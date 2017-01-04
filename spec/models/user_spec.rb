require 'rails_helper'

describe User, type: :model do
  let(:user) { build(:user) }

  context "user attribute validations" do
    it "with first name, last name, and password is valid" do
      expect(user).to be_valid
    end

    it "without a first name is invalid" do
      new_user = build(:user, :first_name => nil)
      expect(new_user).not_to be_valid
    end

    it "without a last name is invalid" do
      new_user = build(:user, :last_name => nil)
      expect(new_user).not_to be_valid
    end

    it "without a password is invalid" do
      new_user = build(:user, password: nil, password_confirmation: nil)
      expect(new_user).not_to be_valid
    end

    it 'validates password length is betwen 8 - 24' do
      should validate_length_of(:password).is_at_least(8).is_at_most(24)
    end
  end

  # ----------------------------------------
  # Associations
  # ----------------------------------------
  context "association with children and parents are valid" do
    subject {user}

    it { should have_one(:profile_pic).dependent(:destroy) }
    it { should have_many(:protocol) }
  end

end
