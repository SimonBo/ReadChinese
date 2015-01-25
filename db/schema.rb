# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150125031041) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "checked_words", force: true do |t|
    t.integer  "user_id"
    t.integer  "word_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "counter",    default: 0
  end

  add_index "checked_words", ["user_id"], name: "index_checked_words_on_user_id", using: :btree
  add_index "checked_words", ["word_id"], name: "index_checked_words_on_word_id", using: :btree

  create_table "favorite_words", force: true do |t|
    t.integer  "user_id"
    t.integer  "word_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "favorite_words", ["user_id"], name: "index_favorite_words_on_user_id", using: :btree
  add_index "favorite_words", ["word_id"], name: "index_favorite_words_on_word_id", using: :btree

  create_table "reading_tests", force: true do |t|
    t.integer  "user_id"
    t.integer  "text_id"
    t.hstore   "data",       default: {}
    t.string   "type",       default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reading_tests", ["data"], name: "reading_tests_gin_data", using: :gin
  add_index "reading_tests", ["text_id"], name: "index_reading_tests_on_text_id", using: :btree
  add_index "reading_tests", ["user_id"], name: "index_reading_tests_on_user_id", using: :btree

  create_table "tests", force: true do |t|
    t.integer  "user_id"
    t.integer  "text_id"
    t.hstore   "data",       default: {}
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tests", ["data"], name: "tests_gin_data", using: :gin
  add_index "tests", ["text_id"], name: "index_tests_on_text_id", using: :btree
  add_index "tests", ["user_id"], name: "index_tests_on_user_id", using: :btree

  create_table "texts", force: true do |t|
    t.text     "content"
    t.string   "source"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title",      null: false
  end

  add_index "texts", ["user_id"], name: "index_texts_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "favorite_words",         default: [],              array: true
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "words", force: true do |t|
    t.string   "traditional_char"
    t.string   "simplified_char"
    t.text     "meaning"
    t.string   "pronunciation"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "pinyin_count"
  end

end
