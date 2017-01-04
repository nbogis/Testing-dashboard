class Testsuite < ApplicationRecord
  include ApplicationHelper
  include TimeModule

  validates :name, presence: true
  belongs_to :protocol

  has_one :documentation, as: :documentable, dependent: :destroy, inverse_of: :documentable

  accepts_nested_attributes_for :documentation, reject_if: :all_blank

  has_many :testcases, dependent: :destroy

  has_many :users, through: :user_testings,
                    source: :user_testable,
                    source_type: 'User'

  has_many :keyword_testings, :as => :keywordable

  has_many :keywords, through: :keyword_testings

  def self.get_users(user_role_type, testsuite_id)
    User.joins("JOIN user_testings ON user_testings.user_id = users.id").
    joins("JOIN testsuites ON user_testings.user_testable_id = testsuites.id").
    where("user_testings.user_role = ?", user_role_type).
    where("user_testings.user_testable_type = ?", "Testsuite").
    where("user_testings.user_testable_id = ?", testsuite_id)
  end

  has_many :tags, through: :test_taggings,
                  source: :test_taggable,
                  source_type: 'Tag'

  def self.get_tags(tag_type, testsuite_id)
    Tag.joins("JOIN test_taggings ON test_taggings.tag_id = tags.id").
    joins("JOIN testsuites ON test_taggings.test_taggable_id = testsuites.id").
    where("test_taggings.tag_role = ?", tag_type).
    where("test_taggings.test_taggable_type = ?", "Testsuite").
    where("test_taggings.test_taggable_id = ?", testsuite_id)
  end

  scope :testsuite_testcase, -> {
    Testsuite.includes(testcases: :case_result)
  }

  def self.suite_case_result
    Testsuite.includes(testcases: :case_result).
    select("testsuites.name AS suite_name","testsuites.id AS suite_id",
    "testsuites.protocol_id","testcases.name AS case_name","testcases.id AS case_id",
    "testcases.execution_time","case_results.result").
    references(:testcases,:case_result)
  end

  # get the final result of the testsuite
  scope :result, -> (testsuite_id) {
    res = Testsuite.suite_case_result.
    where("testsuites.id = #{testsuite_id}").
    pluck(:result)
    if res.count("Pass") == res.length then
      "Pass"
    else
      "Fail"
    end
  }

  # get an array of testcases results and execution time like
  # [["testcase_4_2_2_0", "Fail", 2000-01-01 00:19:29 UTC],
  # ["testcase_4_2_2_1", "Pass", 2000-01-01 00:20:10 UTC]]
  scope :exec_results, -> (testsuite_id) {
    res = Testsuite.suite_case_result.
    where("testsuites.id = #{testsuite_id}")
    .pluck("testcases.name",:result, :execution_time)
  }

  # get total execution time
  scope :exec_time, -> (testsuite_id) {
    res = Testsuite.exec_results(testsuite_id)
    total_time = res.inject(0) {|sum,elem|
      second = TimeModule.convert_to_seconds(elem[2].to_time)
      elem.append(second)
      elem[2] = TimeModule.get_time(elem[2].to_time)
      sum += second
    }
    TimeModule.convert_to_time(total_time)
  }

  # testsuite have either suite/case setup which all have one keyword
  scope :setup_keyword, -> (keyword_role, testsuite_id) {
    Testsuite.includes(:keyword_testings).
    where(keyword_testings: {keywordable_id: "#{testsuite_id}"}).
    first.keywords.
    where(keyword_testings: {keyword_role: "#{keyword_role}"}).last
  }

  # def self.get_results(testsuite_id)
  #   CaseResult.joins("JOIN testcases ON testcases.id = case_results.testcase_id").
  #   joins("JOIN testsuites ON testsuites.id = testcases.testsuite_id").
  #   where("testsuites.id = #{testsuite_id}")
  # end
  #
  # scope :final_result, -> (testsuite_id){
  #   result = Testsuite.get_results(testsuite_id).group(:result).count
  #   if result["Pass"] == result.values.sum then
  #     "Pass"
  #   else
  #     "Fail"
  #   end
  # }

  # def self.get_exec_time(testsuite_id)
  #   testsuite_testcase.where(testsuite: {id: testsuite_id}).
  #   testcases.each do |testcase|
  #     exec_time = testcase.execution_time
  #     name = testcase.name
  #     time = get_time(exec_time)
  #     seconds = convert_to_seconds(exec_time)
  #     @content.push({"name": name,
  #                  "exec_time": time,
  #                  "seconds": seconds,
  #                  "result": Testcase.result(testcase.id).last.result})
  #   end
  # end

  # def self.results(testsuite_id)
  #   Testsuite.includes(testcases: :case_result).
  #   where(testsuites: {id: testsuite_id}).
  #   last.testcases.each {|tcase|
  #     tcase.case_result
  #   }
  # end
end
