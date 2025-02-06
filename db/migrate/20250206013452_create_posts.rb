class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :description
      t.boolean :published, null: false, default: false
      t.text :body
      t.date :published_on
      t.string :publication

      t.timestamps
    end

    add_index :posts, :title
    add_index :posts, :description
    add_index :posts, :published
    add_index :posts, :published_on
    add_index :posts, :publication
  end
end
