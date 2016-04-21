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

ActiveRecord::Schema.define(version: 20160421030651) do

  create_table "answers", force: :cascade do |t|
    t.text     "content",     limit: 65535
    t.integer  "question_id", limit: 4
    t.integer  "user_id",     limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sash_id",     limit: 4
    t.integer  "level",       limit: 4,     default: 0
  end

  add_index "answers", ["question_id"], name: "index_answers_on_question_id", using: :btree
  add_index "answers", ["user_id"], name: "index_answers_on_user_id", using: :btree

  create_table "auth_tokens", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "token",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "auth_tokens", ["user_id"], name: "index_auth_tokens_on_user_id", using: :btree

  create_table "badges_sashes", force: :cascade do |t|
    t.integer  "badge_id",      limit: 4
    t.integer  "sash_id",       limit: 4
    t.boolean  "notified_user",           default: false
    t.datetime "created_at"
  end

  add_index "badges_sashes", ["badge_id", "sash_id"], name: "index_badges_sashes_on_badge_id_and_sash_id", using: :btree
  add_index "badges_sashes", ["badge_id"], name: "index_badges_sashes_on_badge_id", using: :btree
  add_index "badges_sashes", ["sash_id"], name: "index_badges_sashes_on_sash_id", using: :btree

  create_table "bulletins", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "post_type",   limit: 255,   default: "general"
  end

  create_table "bundlelinks", force: :cascade do |t|
    t.string   "title",       limit: 255,                  null: false
    t.text     "description", limit: 65535
    t.integer  "writer_id",   limit: 4,                    null: false
    t.boolean  "shared",                    default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bundlelinks", ["writer_id"], name: "index_bundlelinks_on_writer_id", using: :btree

  create_table "codebanks", force: :cascade do |t|
    t.string   "title",      limit: 255,   null: false
    t.text     "summary",    limit: 65535
    t.text     "snippet",    limit: 65535, null: false
    t.integer  "writer_id",  limit: 4
    t.boolean  "shared"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "codebanks", ["writer_id"], name: "index_codebanks_on_writer_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.integer  "commentable_id",   limit: 4
    t.string   "commentable_type", limit: 255
    t.integer  "writer_id",        limit: 4
    t.text     "content",          limit: 65535, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type", using: :btree
  add_index "comments", ["writer_id"], name: "index_comments_on_writer_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "location",     limit: 255
    t.string   "fb_event_id",  limit: 255
    t.text     "description",  limit: 65535
    t.decimal  "latitude",                   precision: 10, scale: 6
    t.decimal  "longitude",                  precision: 10, scale: 6
    t.datetime "updated_time"
    t.text     "material",     limit: 65535
    t.boolean  "modifiable",                                          default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "event_url",    limit: 255
  end

  create_table "favlinks", force: :cascade do |t|
    t.string   "title",            limit: 255,                  null: false
    t.text     "description",      limit: 65535
    t.string   "linkurl",          limit: 255,                  null: false
    t.integer  "writer_id",        limit: 4
    t.boolean  "shared",                         default: true
    t.integer  "bundlelink_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "capture_loc",      limit: 255
    t.boolean  "with_screen_shot",               default: true
  end

  add_index "favlinks", ["bundlelink_id"], name: "index_favlinks_on_bundlelink_id", using: :btree
  add_index "favlinks", ["writer_id"], name: "index_favlinks_on_writer_id", using: :btree

  create_table "impressions", force: :cascade do |t|
    t.string   "impressionable_type", limit: 255
    t.integer  "impressionable_id",   limit: 4
    t.integer  "user_id",             limit: 4
    t.string   "controller_name",     limit: 255
    t.string   "action_name",         limit: 255
    t.string   "view_name",           limit: 255
    t.string   "request_hash",        limit: 255
    t.string   "ip_address",          limit: 255
    t.string   "session_hash",        limit: 255
    t.text     "message",             limit: 65535
    t.text     "referrer",            limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "impressions", ["controller_name", "action_name", "ip_address"], name: "controlleraction_ip_index", using: :btree
  add_index "impressions", ["controller_name", "action_name", "request_hash"], name: "controlleraction_request_index", using: :btree
  add_index "impressions", ["controller_name", "action_name", "session_hash"], name: "controlleraction_session_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "ip_address"], name: "poly_ip_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "request_hash"], name: "poly_request_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "session_hash"], name: "poly_session_index", using: :btree
  add_index "impressions", ["impressionable_type", "message", "impressionable_id"], name: "impressionable_type_message_index", length: {"impressionable_type"=>nil, "message"=>255, "impressionable_id"=>nil}, using: :btree
  add_index "impressions", ["user_id"], name: "index_impressions_on_user_id", using: :btree

  create_table "labnotes", force: :cascade do |t|
    t.string   "title",       limit: 255,   null: false
    t.text     "summary",     limit: 65535
    t.text     "codesnippet", limit: 65535, null: false
    t.integer  "writer_id",   limit: 4
    t.boolean  "shared"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "labnotes", ["writer_id"], name: "index_labnotes_on_writer_id", using: :btree

  create_table "merit_actions", force: :cascade do |t|
    t.integer  "user_id",       limit: 4
    t.string   "action_method", limit: 255
    t.integer  "action_value",  limit: 4
    t.boolean  "had_errors",                default: false
    t.string   "target_model",  limit: 255
    t.integer  "target_id",     limit: 4
    t.boolean  "processed",                 default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "merit_activity_logs", force: :cascade do |t|
    t.integer  "action_id",           limit: 4
    t.string   "related_change_type", limit: 255
    t.integer  "related_change_id",   limit: 4
    t.string   "description",         limit: 255
    t.datetime "created_at"
  end

  create_table "merit_score_points", force: :cascade do |t|
    t.integer  "score_id",   limit: 4
    t.integer  "num_points", limit: 4,   default: 0
    t.string   "log",        limit: 255
    t.datetime "created_at"
  end

  create_table "merit_scores", force: :cascade do |t|
    t.integer "sash_id",  limit: 4
    t.string  "category", limit: 255, default: "default"
  end

  create_table "plazas", force: :cascade do |t|
    t.integer  "postitable_id",   limit: 4
    t.string   "postitable_type", limit: 255
    t.boolean  "visible"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "plazas", ["postitable_id", "postitable_type"], name: "index_plazas_on_postitable_id_and_postitable_type", using: :btree

  create_table "podcasts", force: :cascade do |t|
    t.string   "uid",            limit: 255
    t.string   "title",          limit: 255
    t.string   "author",         limit: 255
    t.text     "description",    limit: 65535
    t.text     "enclosure_url",  limit: 65535
    t.integer  "enclosure_size", limit: 4,     default: 0
    t.string   "duration",       limit: 255
    t.date     "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title",        limit: 255
    t.text     "content",      limit: 65535
    t.integer  "writer_id",    limit: 4
    t.boolean  "published",                  default: false
    t.datetime "published_at"
    t.integer  "hit",          limit: 4,     default: 0
    t.datetime "deleted_at"
    t.integer  "bulletin_id",  limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "picture",      limit: 255
    t.integer  "sash_id",      limit: 4
    t.integer  "level",        limit: 4,     default: 0
  end

  add_index "posts", ["bulletin_id"], name: "index_posts_on_bulletin_id", using: :btree
  add_index "posts", ["writer_id"], name: "index_posts_on_writer_id", using: :btree

  create_table "purchase_requests", force: :cascade do |t|
    t.integer  "user_id",      limit: 4
    t.date     "req_date",                default: '2016-04-21'
    t.date     "send_date"
    t.string   "sender_name",  limit: 10
    t.integer  "amount",       limit: 4,  default: 0
    t.boolean  "confirmed",               default: false
    t.datetime "confirmed_at"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
  end

  add_index "purchase_requests", ["user_id"], name: "index_purchase_requests_on_user_id", using: :btree

  create_table "questions", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "content",    limit: 65535
    t.integer  "user_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sash_id",    limit: 4
    t.integer  "level",      limit: 4,     default: 0
  end

  add_index "questions", ["user_id"], name: "index_questions_on_user_id", using: :btree

  create_table "rblogs", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "content",    limit: 65535
    t.integer  "writer_id",  limit: 4
    t.boolean  "shared"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rblogs", ["writer_id"], name: "index_rblogs_on_writer_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.integer  "resource_id",   limit: 4
    t.string   "resource_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "sashes", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id",        limit: 4
    t.integer  "taggable_id",   limit: 4
    t.string   "taggable_type", limit: 255
    t.integer  "tagger_id",     limit: 4
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.integer "taggings_count", limit: 4,   default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "useful_answers", id: false, force: :cascade do |t|
    t.integer "user_id",   limit: 4
    t.integer "answer_id", limit: 4
  end

  add_index "useful_answers", ["answer_id", "user_id"], name: "index_useful_answers_on_answer_id_and_user_id", unique: true, using: :btree
  add_index "useful_answers", ["user_id", "answer_id"], name: "index_useful_answers_on_user_id_and_answer_id", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sash_id",                limit: 4
    t.integer  "level",                  limit: 4,   default: 0
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id", limit: 4
    t.integer "role_id", limit: 4
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

  create_table "weeklynews", force: :cascade do |t|
    t.string   "uid",        limit: 255,   null: false
    t.string   "subject",    limit: 255,   null: false
    t.datetime "sended_at",                null: false
    t.text     "url",        limit: 65535, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "weeklynews", ["sended_at"], name: "index_weeklynews_on_sended_at", using: :btree

  add_foreign_key "purchase_requests", "users"
end
