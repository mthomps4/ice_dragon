class Collection < ApplicationRecord
  PUBLICATIONS = Post::PUBLICATIONS
  PUBLICATION_VALUES = Post::PUBLICATION_VALUES
  PUBLICATION_OPTIONS = Post::PUBLICATION_OPTIONS

  has_many :collection_posts, dependent: :destroy
  has_many :posts, through: :collection_posts

  validates :name, presence: true, uniqueness: true

  accepts_nested_attributes_for :collection_posts, allow_destroy: true

  def self.ransackable_attributes(auth_object = nil)
    %w[id name]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[posts]
  end
end
