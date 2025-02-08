class Collection < ApplicationRecord
  PUBLICATIONS = Post::PUBLICATIONS
  PUBLICATION_VALUES = Post::PUBLICATION_VALUES
  PUBLICATION_OPTIONS = Post::PUBLICATION_OPTIONS

  has_many :collection_posts, dependent: :destroy
  has_many :posts, through: :collection_posts

  validates :name, presence: true, uniqueness: true

  accepts_nested_attributes_for :collection_posts, allow_destroy: true
end
