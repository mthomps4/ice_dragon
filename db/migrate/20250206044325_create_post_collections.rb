class CreatePostCollections < ActiveRecord::Migration[8.0]
  def change
    create_table :post_collections do |t|
      t.references :post, null: false, foreign_key: true
      t.references :collection, null: false, foreign_key: true
      t.integer :order

      t.timestamps
    end

    add_index :post_collections, [ :collection_id, :post_id, :order ], unique: true, name: "index_collection_post_order"
  end
end
