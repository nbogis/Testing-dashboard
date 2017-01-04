class CaseResult < ApplicationRecord

  belongs_to :testcase

  validates :result, presence: true

end
