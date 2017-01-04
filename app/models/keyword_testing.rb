class KeywordTesting < ApplicationRecord
  belongs_to :keywordable, polymorphic: :true
  belongs_to :keyword

  scope :suite_setup, -> {where(keyword_role: "suite setup")}
  scope :suite_teardown, -> {where(keyword_role: "suite teardown")}
  scope :test_setup, -> {where(keyword_role: "test setup")}
  scope :test_teardown, -> {where(keyword_role: "test teardown")}
end
