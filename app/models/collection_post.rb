class CollectionPost < ApplicationRecord
  belongs_to :collection
  belongs_to :post

  def self.ransackable_attributes(auth_object = nil)
    [ "id", "collection_id", "post_id" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "collection", "post" ]
  end
end
