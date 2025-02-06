class Post < ApplicationRecord
  PUBLICATION_VALUES = %w[digital_forge hand_tool_armory].freeze
  PUBLICATION_OPTIONS = PUBLICATION_VALUES.map { |value| [ value.titleize, value ] }

  # Validations
  validates :title, presence: true
  validates :publication, inclusion: { in: PUBLICATION_VALUES }

  # Callbacks
  before_validation :set_published_on, if: -> { published? }

  # Scopes
  scope :published, -> { where(published: true) }

  # Methods
  def set_published_on
    self.published_on = Time.current if published?
  end
end
