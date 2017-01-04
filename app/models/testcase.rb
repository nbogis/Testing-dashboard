class Testcase < ApplicationRecord
  include TimeModule

  validates :name, presence: true
  belongs_to :testsuite

  has_one :documentation, as: :documentable, dependent: :destroy, inverse_of: :documentable

  has_one :case_result, dependent: :destroy

  has_many :users, through: :user_testings,
                    source: :user_testable,
                    source_type: 'User'

  has_many :keyword_testings, :as => :keywordable
  has_many :keywords, through: :keyword_testings

  has_many :tags, through: :test_taggings,
                  source: :test_taggable,
                  source_type: 'Tag'

  def self.get_users(user_role_type, testcase_id)
    User.joins("JOIN user_testings ON user_testings.user_id = users.id").
    joins("JOIN testcases ON user_testings.user_testable_id = testcases.id").
    where("user_testings.user_role = ?", user_role_type).
    where("user_testings.user_testable_type = ?", "Testcase").
    where("user_testings.user_testable_id = ?", testcase_id)
  end

  def self.get_tags(tag_type, testcase_id)
    Tag.joins("JOIN test_taggings ON test_taggings.tag_id = tags.id").
    joins("JOIN testcases ON test_taggings.test_taggable_id = testcases.id").
    where("test_taggings.tag_role = ?", tag_type).
    where("test_taggings.test_taggable_type = ?", "Testcase").
    where("test_taggings.test_taggable_id = ?", testcase_id)
  end

  def self.get_keywords(keyword_role, testcase_id)
    Testcase.includes(:keyword_testings).
    where(keyword_testings: {keyword_role: "#{keyword_role}"}).
    first.keywords.
    where(keyword_testings: {keywordable_id: "#{testcase_id}"})
  end

  scope :result, -> (testcase_id) {
    CaseResult.where(testcase_id: testcase_id)
  }
end
