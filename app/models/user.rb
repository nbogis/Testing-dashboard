class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true

  has_many :user_testings
  has_many :protocols, through: :user_testings, source: :user_testable, source_type: 'Protocol'
  has_many :testsuties, through: :user_testings, source: :user_testable, source_type: 'Testsuite'

  # scopes to get allo the users with the specified role
  scope :as_executors, -> {joins(:user_testings).merge(UserTesting.executors)}
  scope :as_creator, -> {joins(:user_testings).merge(UserTesting.creator)}
  scope :as_modifiers, -> {joins(:user_testings).merge(UserTesting.modifiers)}

  # used like User.get_tests("modifier",Protocol, 18)
  def self.get_tests(user_role_type, test_type, user_id)
    test_type.joins("JOIN user_testings ON user_testings.user_testable_id = #{test_type.to_s.downcase.pluralize}.id").
    joins("JOIN users ON user_testings.user_id = users.id").
    where("user_testings.user_role = ?", user_role_type).
    where("user_testings.user_testable_type = ?", test_type).
    where("user_testings.user_id = ?", user_id)
  end
end
