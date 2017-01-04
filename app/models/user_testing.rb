class UserTesting < ApplicationRecord
  belongs_to :user_testable, polymorphic: :true
  belongs_to :user

  scope :executors, -> {where(user_role: "executor")}
  scope :creator, -> {where(user_role: "creator")}
  scope :modifiers, -> {where(user_role: "modifier")}
end
