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

ActiveRecord::Schema.define(version: 20160614111206) do

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

  create_table "appliers", force: :cascade do |t|
    t.integer  "schedule_id", limit: 4
    t.integer  "user_id",     limit: 4
    t.string   "name",        limit: 255,                   null: false
    t.string   "email",       limit: 255,                   null: false
    t.string   "cellphone",   limit: 255
    t.string   "remittor",    limit: 255
    t.datetime "remit_date"
    t.integer  "remit_money", limit: 4,     default: 0
    t.text     "memo",        limit: 65535
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.boolean  "accepted",                  default: false
  end

  add_index "appliers", ["schedule_id"], name: "index_appliers_on_schedule_id", using: :btree
  add_index "appliers", ["user_id"], name: "index_appliers_on_user_id", using: :btree

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

  create_table "courses", force: :cascade do |t|
    t.string   "title",        limit: 255,                   null: false
    t.text     "summary",      limit: 65535
    t.integer  "tutor_id",     limit: 4
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.boolean  "published",                  default: false
    t.datetime "published_at"
  end

  add_index "courses", ["tutor_id"], name: "index_courses_on_tutor_id", using: :btree

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   limit: 4,     default: 0, null: false
    t.integer  "attempts",   limit: 4,     default: 0, null: false
    t.text     "handler",    limit: 65535,             null: false
    t.text     "last_error", limit: 65535
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

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

  create_table "glossaries", force: :cascade do |t|
    t.integer  "user_id",       limit: 4
    t.string   "term",          limit: 255,   null: false
    t.integer  "word_class",    limit: 4
    t.boolean  "idiomatic"
    t.text     "memo",          limit: 65535
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "word_class_cd", limit: 4
  end

  add_index "glossaries", ["user_id"], name: "index_glossaries_on_user_id", using: :btree

  create_table "glossary_definitions", force: :cascade do |t|
    t.integer  "glossary_id", limit: 4
    t.integer  "user_id",     limit: 4
    t.string   "definition",  limit: 255,   null: false
    t.text     "sentence",    limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "glossary_definitions", ["glossary_id"], name: "index_glossary_definitions_on_glossary_id", using: :btree
  add_index "glossary_definitions", ["user_id"], name: "index_glossary_definitions_on_user_id", using: :btree

  create_table "group_purchases", force: :cascade do |t|
    t.string   "event_name", limit: 255,   null: false
    t.text     "event_info", limit: 65535
    t.datetime "start_date",               null: false
    t.datetime "end_date"
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "group_purchases", ["user_id"], name: "index_group_purchases_on_user_id", using: :btree

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

  create_table "items", force: :cascade do |t|
    t.integer  "purchase_request_id", limit: 4
    t.string   "shirts_color",        limit: 1
    t.string   "shirts_size",         limit: 3
    t.integer  "count",               limit: 4, default: 0
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  add_index "items", ["purchase_request_id"], name: "index_items_on_purchase_request_id", using: :btree

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

  create_table "lectures", force: :cascade do |t|
    t.integer  "course_id",    limit: 4
    t.string   "title",        limit: 255,                   null: false
    t.text     "content",      limit: 65535
    t.string   "youtube_url",  limit: 255
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "user_id",      limit: 4
    t.boolean  "published",                  default: false
    t.datetime "published_at"
  end

  add_index "lectures", ["course_id"], name: "index_lectures_on_course_id", using: :btree
  add_index "lectures", ["user_id"], name: "index_lectures_on_user_id", using: :btree

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
    t.integer  "user_id",           limit: 4
    t.date     "send_date"
    t.string   "sender_name",       limit: 10
    t.integer  "send_total_price",  limit: 4,     default: 0
    t.boolean  "confirmed",                       default: false
    t.datetime "confirmed_at"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.boolean  "delivery",                        default: false
    t.string   "parcel_zip",        limit: 10
    t.string   "parcel_addr",       limit: 255
    t.string   "parcel_receiver",   limit: 10
    t.text     "memo",              limit: 65535
    t.integer  "group_purchase_id", limit: 4
    t.boolean  "deleted",                         default: false
    t.datetime "deleted_at"
    t.integer  "deleted_by_id",     limit: 4
  end

  add_index "purchase_requests", ["deleted_by_id"], name: "index_purchase_requests_on_deleted_by_id", using: :btree
  add_index "purchase_requests", ["group_purchase_id"], name: "index_purchase_requests_on_group_purchase_id", using: :btree
  add_index "purchase_requests", ["user_id"], name: "index_purchase_requests_on_user_id", using: :btree

  create_table "questionnaires", force: :cascade do |t|
    t.string   "title",       limit: 255,   null: false
    t.text     "description", limit: 65535
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "writer_id",   limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "questionnaires", ["writer_id"], name: "index_questionnaires_on_writer_id", using: :btree

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

  create_table "recommandations", force: :cascade do |t|
    t.integer  "schedule_id",    limit: 4
    t.integer  "applier_id",     limit: 4
    t.integer  "recommander_id", limit: 4
    t.integer  "score",          limit: 4,     default: 0
    t.text     "letter",         limit: 65535
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "recommandations", ["applier_id"], name: "index_recommandations_on_applier_id", using: :btree
  add_index "recommandations", ["recommander_id"], name: "index_recommandations_on_recommander_id", using: :btree
  add_index "recommandations", ["schedule_id"], name: "index_recommandations_on_schedule_id", using: :btree

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

  create_table "schedules", force: :cascade do |t|
    t.integer  "user_id",        limit: 4
    t.string   "name",           limit: 255,                   null: false
    t.text     "info",           limit: 65535
    t.string   "venue",          limit: 255
    t.datetime "start_date"
    t.datetime "end_date"
    t.boolean  "repeating"
    t.boolean  "charged",                      default: false
    t.integer  "charge_amount",  limit: 4,     default: 0
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.datetime "pre_start_date"
    t.datetime "pre_end_date"
  end

  add_index "schedules", ["user_id"], name: "index_schedules_on_user_id", using: :btree

  create_table "survey_options", force: :cascade do |t|
    t.integer  "survey_request_id", limit: 4
    t.string   "item_key",          limit: 255, null: false
    t.integer  "item_value",        limit: 4,   null: false
    t.integer  "writer_id",         limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "survey_options", ["survey_request_id"], name: "index_survey_options_on_survey_request_id", using: :btree
  add_index "survey_options", ["writer_id"], name: "index_survey_options_on_writer_id", using: :btree

  create_table "survey_requests", force: :cascade do |t|
    t.integer  "questionnaire_id", limit: 4
    t.string   "title",            limit: 255,                   null: false
    t.text     "description",      limit: 65535
    t.boolean  "required",                       default: false
    t.integer  "writer_id",        limit: 4
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.integer  "pattern_cd",       limit: 4
  end

  add_index "survey_requests", ["questionnaire_id"], name: "index_survey_requests_on_questionnaire_id", using: :btree
  add_index "survey_requests", ["writer_id"], name: "index_survey_requests_on_writer_id", using: :btree

  create_table "survey_responses", force: :cascade do |t|
    t.integer  "survey_request_id", limit: 4
    t.string   "answer_short",      limit: 255
    t.text     "answer_long",       limit: 65535
    t.string   "answer_single",     limit: 255
    t.string   "answer_multi",      limit: 255
    t.integer  "writer_id",         limit: 4
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "survey_responses", ["survey_request_id"], name: "index_survey_responses_on_survey_request_id", using: :btree
  add_index "survey_responses", ["writer_id"], name: "index_survey_responses_on_writer_id", using: :btree

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

  create_table "user_profiles", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "name",       limit: 255,   null: false
    t.string   "github",     limit: 255
    t.text     "intro",      limit: 65535, null: false
    t.string   "blog",       limit: 255
    t.string   "website",    limit: 255
    t.string   "company",    limit: 255
    t.string   "title",      limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "avatar",     limit: 255
  end

  add_index "user_profiles", ["user_id"], name: "index_user_profiles_on_user_id", using: :btree

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

  add_foreign_key "appliers", "schedules"
  add_foreign_key "appliers", "users"
  add_foreign_key "courses", "users", column: "tutor_id"
  add_foreign_key "glossaries", "users"
  add_foreign_key "glossary_definitions", "glossaries"
  add_foreign_key "glossary_definitions", "users"
  add_foreign_key "group_purchases", "users"
  add_foreign_key "items", "purchase_requests"
  add_foreign_key "lectures", "courses"
  add_foreign_key "lectures", "users"
  add_foreign_key "purchase_requests", "group_purchases"
  add_foreign_key "purchase_requests", "users"
  add_foreign_key "purchase_requests", "users", column: "deleted_by_id"
  add_foreign_key "questionnaires", "users", column: "writer_id"
  add_foreign_key "recommandations", "appliers"
  add_foreign_key "recommandations", "schedules"
  add_foreign_key "recommandations", "users", column: "recommander_id"
  add_foreign_key "schedules", "users"
  add_foreign_key "survey_options", "survey_requests"
  add_foreign_key "survey_options", "users", column: "writer_id"
  add_foreign_key "survey_requests", "questionnaires"
  add_foreign_key "survey_requests", "users", column: "writer_id"
  add_foreign_key "survey_responses", "survey_requests"
  add_foreign_key "survey_responses", "users", column: "writer_id"
  add_foreign_key "user_profiles", "users"
end
