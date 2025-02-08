class Post < ApplicationRecord
  PUBLICATIONS = {
    digital_forge: "digital_forge",
    hand_tool_armory: "hand_tool_armory"
  }.freeze
  PUBLICATION_VALUES = PUBLICATIONS.values.freeze
  PUBLICATION_OPTIONS = PUBLICATION_VALUES.map { |value| [ value.titleize, value ] }

  before_validation :generate_slug

  # Validations
  validates :title, presence: true
  validates :publication, inclusion: { in: PUBLICATION_VALUES }

  # Callbacks
  before_validation :set_published_on, if: -> { published? }

  # Associations
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  has_many :collection_posts, dependent: :destroy
  has_many :collections, through: :collection_posts

  # Validations
  accepts_nested_attributes_for :tags, allow_destroy: true, reject_if: :all_blank
  validates_associated :tags

  # Scopes
  scope :published, -> { where(published: true) }

  # Methods
  def set_published_on
    self.published_on = Time.current if published?
  end

  def generate_slug
    self.slug = title.parameterize
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[title description body]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[tags collections]
  end
end
