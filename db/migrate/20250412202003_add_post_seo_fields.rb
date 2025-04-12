class AddPostSeoFields < ActiveRecord::Migration[8.0]
  def change
    add_column :posts, :meta_title, :string, null: false, default: ""
    add_column :posts, :meta_description, :string, null: false, default: ""
    add_column :posts, :keywords, :string, null: false, default: ""
    add_column :posts, :featured_image, :string
    add_column :posts, :featured_alt_text, :string, null: false, default: "post featured image"
    add_column :posts, :canonical_url, :string, null: true
  end
end
