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

ActiveRecord::Schema.define(version: 20161122011945) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attachments", force: :cascade do |t|
    t.string   "attach_file_name"
    t.string   "attach_content_type"
    t.string   "attach_file_size"
    t.binary   "file_contents"
    t.integer  "protocol_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["protocol_id"], name: "index_attachments_on_protocol_id", using: :btree
  end

  create_table "case_results", force: :cascade do |t|
    t.string   "result"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "testcase_id"
    t.index ["testcase_id"], name: "index_case_results_on_testcase_id", using: :btree
  end

  create_table "documentations", force: :cascade do |t|
    t.text    "body"
    t.integer "documentable_id"
    t.string  "documentable_type"
    t.index ["documentable_id", "documentable_type"], name: "index_documentations_on_documentable_id_and_documentable_type", using: :btree
  end

  create_table "keyword_testings", force: :cascade do |t|
    t.integer  "keyword_id"
    t.string   "keyword_role"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "keywordable_type"
    t.integer  "keywordable_id"
    t.index ["keywordable_type", "keywordable_id"], name: "index_keyword_testings_on_keywordable_type_and_keywordable_id", using: :btree
  end

  create_table "keywords", force: :cascade do |t|
    t.string   "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.integer  "dhf_num"
    t.string   "executor_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "protocols", force: :cascade do |t|
    t.string   "name"
    t.integer  "product_id"
    t.string   "revision"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_protocols_on_product_id", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "test_taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.string   "tag_role"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "test_taggable_type"
    t.integer  "test_taggable_id"
    t.index ["tag_id"], name: "index_test_taggings_on_tag_id", using: :btree
    t.index ["test_taggable_type", "test_taggable_id"], name: "index_test_taggings_on_test_taggable_type_and_test_taggable_id", using: :btree
  end

  create_table "testcases", force: :cascade do |t|
    t.string   "name"
    t.integer  "testsuite_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.time     "execution_time"
    t.string   "template"
    t.time     "timeout"
    t.index ["testsuite_id"], name: "index_testcases_on_testsuite_id", using: :btree
  end

  create_table "testsuites", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "protocol_id"
    t.string   "test_template"
    t.time     "test_timeout"
    t.string   "source"
    t.string   "library"
    t.index ["protocol_id"], name: "index_testsuites_on_protocol_id", using: :btree
  end

  create_table "user_testings", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "user_role"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "user_testable_type"
    t.integer  "user_testable_id"
    t.index ["user_id"], name: "index_user_testings_on_user_id", using: :btree
    t.index ["user_testable_type", "user_testable_id"], name: "index_user_testings_on_user_testable_type_and_user_testable_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "attachments", "protocols"
  add_foreign_key "case_results", "testcases"
  add_foreign_key "protocols", "products"
  add_foreign_key "test_taggings", "tags"
  add_foreign_key "testcases", "testsuites"
  add_foreign_key "testsuites", "protocols"
  add_foreign_key "user_testings", "users"
end
