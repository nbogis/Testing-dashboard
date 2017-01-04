class Documentation < ApplicationRecord
  # create a polymorphism relationship
  belongs_to :documentable, polymorphic: true, inverse_of: :documentation

  validates :body, length: {maximum: 800}
end
