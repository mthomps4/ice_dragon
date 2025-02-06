class CreateCollections < ActiveRecord::Migration[8.0]
  def change
    create_table :collections do |t|
      t.string :name

      t.timestamps
    end

    add_index :collections, :name, unique: true
  end
end
