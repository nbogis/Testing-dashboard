class Tag < ApplicationRecord
  validates :name, uniqueness: true
  has_many :test_taggings
  has_many :test_suites, through: :test_taggings,
                         source: :test_taggable,
                         source_type: "Testsuite"

  # get all the tests with the specified tag and test types
  # used like Tag.get_tests("default s", Testsuite, 9)
  def self.get_tests(tag_type, test_type,tag_id)
    test_type.joins("JOIN test_taggings ON test_taggings.test_taggable_id = #{test_type.to_s.downcase.pluralize}.id").
    joins("JOIN tags ON test_taggings.tag_id = tags.id").
    where("test_taggings.tag_role = ?", tag_type).
    where("test_taggings.test_taggable_type = ?",test_type).
    where("test_taggings.tag_id = ?", tag_id)
  end
end
