class Post < ApplicationRecord
  PUBLICATION_VALUES = %w[digital_forge hand_tool_armory].freeze
  PUBLICATION_OPTIONS = PUBLICATION_VALUES.map { |value| [ value.titleize, value ] }

  # Validations
  validates :title, presence: true
  validates :publication, inclusion: { in: PUBLICATION_VALUES }

  # Callbacks
  before_validation :set_published_on, if: -> { published? }

  # Associations
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  # Validations
  accepts_nested_attributes_for :tags, allow_destroy: true, reject_if: :all_blank
  validates_associated :tags

  has_many :collection_posts, dependent: :destroy
  has_many :collections, through: :collection_posts

  # Scopes
  scope :published, -> { where(published: true) }

  # Methods
  def set_published_on
    self.published_on = Time.current if published?
  end
end
