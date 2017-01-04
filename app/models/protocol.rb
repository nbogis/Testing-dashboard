class Protocol < ApplicationRecord
  include TimeModule

  validates :name, presence: true

  belongs_to :product

  has_many :testsuites, dependent: :destroy

  # polymorphic relationship with documentation
  # inverse_of tells ActiveRecord to use the same object in memory and not create a copy
  # so protocol.documentation == documentation since the record is already in memory
  has_one :documentation, as: :documentable, dependent: :destroy, inverse_of: :documentable

  accepts_nested_attributes_for :documentation, reject_if: :all_blank

  has_many :attachments, dependent: :destroy

  has_many :user_testings, as: :user_testable

  has_many :users, through: :user_testings, source: :user_testable,source_type: 'User'

  scope :exec_results, -> (protocol) {
    res = []
    protocol.testsuites.each { |suite|
      # get testsuite's final result
      res.push([suite.name,
                Testsuite.result(suite.id),
                Testsuite.exec_time(suite.id)])
    }
    res
  }
  # final result of the protocol
  scope :result, -> (protocol) {
    res = []
    protocol.testsuites.each { |suite|
      res.push(Testsuite.result(suite.id))
    }
    if res.count("Pass") == res.length then
      "Pass"
    else
      "Fail"
    end
  }

  # total execution time for the protocol
  scope :exec_time, -> (protocol) {
    total_time = protocol.testsuites.inject(0) { |sum,suite|
      second = TimeModule.convert_to_seconds(Testsuite.exec_time(suite.id).to_time)
      sum += second
    }
    TimeModule.convert_to_time(total_time)
  }

  def self.get_users(user_role_type, id)
    User.joins("JOIN user_testings ON user_testings.user_id = users.id").
    joins("JOIN protocols ON user_testings.user_testable_id = protocols.id").
    where("user_testings.user_role = ?", user_role_type).
    where("user_testings.user_testable_type = ?", "Protocol").
    where("user_testings.user_testable_id = ?", id)
  end

end
