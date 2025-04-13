class Post < ApplicationRecord
  PUBLICATIONS = {
    digital_forge: "digital_forge",
    hand_tool_armory: "hand_tool_armory"
  }.freeze
  PUBLICATION_VALUES = PUBLICATIONS.values.freeze
  PUBLICATION_OPTIONS = PUBLICATION_VALUES.map { |value| [ value.titleize, value ] }

  DEFAULT_OG_IMAGE = "https://ik.imagekit.io/mthomps4/site/default_og.png"
  DEFAULT_FEATURED_IMAGE = "https://ik.imagekit.io/mthomps4/site/featured_default.png"

  # Validations
  validates :title, presence: true
  validates :publication, inclusion: { in: PUBLICATION_VALUES }
  validates :meta_title, presence: true
  validates :meta_description, presence: true
  validates :og_image, presence: true
  validates :og_image_alt_text, presence: true

  # Callbacks
  before_validation :generate_slug
  before_validation :set_published_on, if: -> { published? }
  before_validation :set_meta_title, if: -> { meta_title.blank? }
  before_validation :set_meta_description, if: -> { meta_description.blank? }
  before_validation :unset_published, if: -> { archived? }
  before_validation :set_og_image, if: -> { og_image.blank? }
  before_validation :set_featured_image, if: -> { featured_image.blank? }

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
  def set_featured_image
    self.featured_image = DEFAULT_FEATURED_IMAGE if featured_image.blank?
  end

  def set_og_image
    self.og_image = DEFAULT_OG_IMAGE if og_image.blank?
  end

  def unset_published
    self.published = false if archived?
  end

  def set_published_on
    self.published_on = Time.current if published?
  end

  def set_meta_title
    self.meta_title = title if meta_title.blank?
  end

  def set_meta_description
    self.meta_description = description if meta_description.blank?
  end

  def generate_slug
    self.slug = title.parameterize
  end

  def status
    return "Archived" if archived?
    return "Published" if published?
    "Draft"
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[title description body]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[tags collections]
  end
end
