class CreateCollectionPosts < ActiveRecord::Migration[8.0]
  def change
    create_table :collection_posts do |t|
      t.references :collection, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
