class Keyword < ApplicationRecord

  validates :body, uniqueness: true

  has_many :keyword_testings, :dependent => :destroy

  has_many :test_suites, through: :keyword_testings,
                         source: :keywordable,
                         source_type: "Testsuite"

  has_many :testcases, through: :keyword_testings,
                         source: :keywordable,
                         source_type: "Testcase"

 # get all the tests with the specified tag and test types
 # used like:  Keyword.get_tests("teardown",Testcase,9)
  def self.get_tests(keyword_type, test_type,keyword_id)
   test_type.joins("JOIN keyword_testings ON keyword_testings.keywordable_id = #{test_type.to_s.downcase.pluralize}.id").
   joins("JOIN keywords ON keyword_testings.keyword_id = keywords.id").
   where("keyword_testings.keyword_role = ?", keyword_type).
   where("keyword_testings.keywordable_type = ?",test_type).
   where("keyword_testings.keyword_id = ?", keyword_id)
  end

end
