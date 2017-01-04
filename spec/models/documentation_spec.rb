require 'rails_helper'

describe Documentation, type: :model do
  let(:documentation) { build(:documentaion)}

  it { is_expected.to belong_to(:documentable)}

  it { should validate_length_of(:body).is_at_most(800)}

end
