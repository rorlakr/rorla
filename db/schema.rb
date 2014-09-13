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

ActiveRecord::Schema.define(version: 20140913024616) do

  create_table "answers", force: true do |t|
    t.text     "content"
    t.integer  "question_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "answers", ["question_id"], name: "index_answers_on_question_id"
  add_index "answers", ["user_id"], name: "index_answers_on_user_id"

  create_table "auth_tokens", force: true do |t|
    t.integer  "user_id"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "auth_tokens", ["user_id"], name: "index_auth_tokens_on_user_id"

  create_table "bulletins", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "post_type",   default: "general"
  end

  create_table "bundlelinks", force: true do |t|
    t.string   "title",                      null: false
    t.text     "description"
    t.integer  "writer_id",                  null: false
    t.boolean  "shared",      default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bundlelinks", ["writer_id"], name: "index_bundlelinks_on_writer_id"

  create_table "comments", force: true do |t|
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "writer_id"
    t.text     "content",          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type"
  add_index "comments", ["writer_id"], name: "index_comments_on_writer_id"

  create_table "events", force: true do |t|
    t.string   "name"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "location"
    t.string   "fb_event_id"
    t.text     "description"
    t.decimal  "latitude",     precision: 10, scale: 6
    t.decimal  "longitude",    precision: 10, scale: 6
    t.datetime "updated_time"
    t.text     "material"
    t.boolean  "modifiable",                            default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "favlinks", force: true do |t|
    t.string   "title",                           null: false
    t.text     "description"
    t.string   "linkurl",                         null: false
    t.integer  "writer_id"
    t.boolean  "shared",           default: true
    t.integer  "bundlelink_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "capture_loc"
    t.boolean  "with_screen_shot", default: true
  end

  add_index "favlinks", ["bundlelink_id"], name: "index_favlinks_on_bundlelink_id"
  add_index "favlinks", ["writer_id"], name: "index_favlinks_on_writer_id"

  create_table "plazas", force: true do |t|
    t.integer  "postitable_id"
    t.string   "postitable_type"
    t.boolean  "visible"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "plazas", ["postitable_id", "postitable_type"], name: "index_plazas_on_postitable_id_and_postitable_type"

  create_table "podcasts", force: true do |t|
    t.string   "uid"
    t.string   "title"
    t.string   "author"
    t.text     "description"
    t.text     "enclosure_url"
    t.integer  "enclosure_size", default: 0
    t.string   "duration"
    t.date     "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "writer_id"
    t.boolean  "published",    default: false
    t.datetime "published_at"
    t.integer  "hit",          default: 0
    t.datetime "deleted_at"
    t.integer  "bulletin_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "picture"
  end

  add_index "posts", ["bulletin_id"], name: "index_posts_on_bulletin_id"
  add_index "posts", ["writer_id"], name: "index_posts_on_writer_id"

  create_table "questions", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "questions", ["user_id"], name: "index_questions_on_user_id"

  create_table "rblogs", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "writer_id"
    t.boolean  "shared"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rblogs", ["writer_id"], name: "index_rblogs_on_writer_id"

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], name: "index_roles_on_name"

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", force: true do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true

  create_table "useful_answers", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "answer_id"
  end

  add_index "useful_answers", ["answer_id", "user_id"], name: "index_useful_answers_on_answer_id_and_user_id", unique: true
  add_index "useful_answers", ["user_id", "answer_id"], name: "index_useful_answers_on_user_id_and_answer_id", unique: true

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"

end
