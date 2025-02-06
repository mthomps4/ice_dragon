class PostCollection < ApplicationRecord
  belongs_to :post
  belongs_to :collection
end
