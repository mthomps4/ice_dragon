class AddPublicationToCollection < ActiveRecord::Migration[8.0]
  def change
    add_column :collections, :publication, :string
  end
end
