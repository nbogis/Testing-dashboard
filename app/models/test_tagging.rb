class TestTagging < ApplicationRecord
  belongs_to :test_taggable, polymorphic: :true
  belongs_to :tag

  scope :default_tag, -> {where(tag_role: "default tag")}
  scope :force_tag, -> {where(tag_role: "force tag")}
end
