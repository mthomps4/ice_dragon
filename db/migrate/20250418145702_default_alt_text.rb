class DefaultAltText < ActiveRecord::Migration[8.0]
  def change
    change_column_default :posts, :og_image_alt_text, from: "", to: "og image"
  end
end
