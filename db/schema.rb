# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160728162029) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.string   "content"
    t.integer  "post_id"
    t.integer  "user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "time_in_episode"
    t.index ["post_id"], name: "index_comments_on_post_id", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "episodes", force: :cascade do |t|
    t.string   "title"
    t.datetime "air_date"
    t.integer  "runtime"
    t.integer  "season"
    t.string   "episode_number"
    t.integer  "show_id"
    t.integer  "tvrage_e_id"
    t.index ["show_id"], name: "index_episodes_on_show_id", using: :btree
  end

  create_table "feeds", force: :cascade do |t|
    t.integer  "episode_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "species"
    t.datetime "start_time"
    t.string   "name"
    t.index ["episode_id"], name: "index_feeds_on_episode_id", using: :btree
  end

  create_table "pg_search_documents", force: :cascade do |t|
    t.text     "content"
    t.string   "searchable_type"
    t.integer  "searchable_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable_type_and_searchable_id", using: :btree
  end

  create_table "posts", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "time_in_episode"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "feed_id"
    t.string   "feed_name"
    t.index ["feed_id"], name: "index_posts_on_feed_id", using: :btree
    t.index ["user_id"], name: "index_posts_on_user_id", using: :btree
  end

  create_table "shows", force: :cascade do |t|
    t.string  "title"
    t.string  "cover_img_url"
    t.text    "summary"
    t.boolean "confirmed",     default: false
    t.integer "tvrage_id"
  end

  create_table "shows_users", force: :cascade do |t|
    t.integer "show_id"
    t.integer "user_id"
    t.index ["show_id"], name: "index_shows_users_on_show_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",      null: false
    t.string   "encrypted_password",     default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.text     "bio"
    t.string   "screen_name"
    t.string   "location"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "avatar"
    t.string   "provider",               default: "email", null: false
    t.string   "uid",                    default: "",      null: false
    t.json     "tokens"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "votes", force: :cascade do |t|
    t.string   "votable_type"
    t.integer  "votable_id"
    t.string   "voter_type"
    t.integer  "voter_id"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope", using: :btree
    t.index ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope", using: :btree
  end

  create_table "watches", force: :cascade do |t|
    t.integer "watcher_id"
    t.integer "watched_id"
  end

  add_foreign_key "comments", "posts"
  add_foreign_key "comments", "users"
  add_foreign_key "episodes", "shows"
  add_foreign_key "feeds", "episodes"
  add_foreign_key "posts", "users"
  add_foreign_key "shows_users", "shows"
end
