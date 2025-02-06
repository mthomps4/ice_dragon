# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_02_06_044325) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "collections", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_collections_on_name", unique: true
  end

  create_table "post_collections", force: :cascade do |t|
    t.bigint "post_id", null: false
    t.bigint "collection_id", null: false
    t.integer "order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["collection_id", "post_id", "order"], name: "index_collection_post_order", unique: true
    t.index ["collection_id"], name: "index_post_collections_on_collection_id"
    t.index ["post_id"], name: "index_post_collections_on_post_id"
  end

  create_table "post_tags", force: :cascade do |t|
    t.bigint "post_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_post_tags_on_post_id"
    t.index ["tag_id"], name: "index_post_tags_on_tag_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.boolean "published", default: false, null: false
    t.text "body"
    t.date "published_on"
    t.string "publication"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "archived", default: false
    t.index ["description"], name: "index_posts_on_description"
    t.index ["publication"], name: "index_posts_on_publication"
    t.index ["published"], name: "index_posts_on_published"
    t.index ["published_on"], name: "index_posts_on_published_on"
    t.index ["title"], name: "index_posts_on_title"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  add_foreign_key "post_collections", "collections"
  add_foreign_key "post_collections", "posts"
  add_foreign_key "post_tags", "posts"
  add_foreign_key "post_tags", "tags"
end
