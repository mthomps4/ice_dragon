class AddBlogImage < ActiveRecord::Migration[8.0]
  def change
    add_column :posts, :og_image, :string
    add_column :posts, :og_image_alt_text, :string
  end
end
