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

ActiveRecord::Schema.define(version: 2019_07_11_094150) do

  create_table "answers", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.text "content"
    t.integer "question_id"
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "sash_id"
    t.integer "level", default: 0
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["user_id"], name: "index_answers_on_user_id"
  end

  create_table "appliers", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "schedule_id"
    t.integer "user_id"
    t.string "name", null: false
    t.string "email", null: false
    t.string "cellphone"
    t.string "remittor"
    t.datetime "remit_date"
    t.integer "remit_money", default: 0
    t.text "memo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "accepted", default: false
    t.index ["schedule_id"], name: "index_appliers_on_schedule_id"
    t.index ["user_id"], name: "index_appliers_on_user_id"
  end

  create_table "articles", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "newsletter_id"
    t.integer "news_section_id"
    t.string "title", null: false
    t.text "content"
    t.string "poster"
    t.string "reference_url"
    t.integer "reporter_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["news_section_id"], name: "index_articles_on_news_section_id"
    t.index ["newsletter_id"], name: "index_articles_on_newsletter_id"
    t.index ["reporter_id"], name: "index_articles_on_reporter_id"
  end

  create_table "auth_tokens", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "user_id"
    t.string "token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], name: "index_auth_tokens_on_user_id"
  end

  create_table "badges_sashes", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "badge_id"
    t.integer "sash_id"
    t.boolean "notified_user", default: false
    t.datetime "created_at"
    t.index ["badge_id", "sash_id"], name: "index_badges_sashes_on_badge_id_and_sash_id"
    t.index ["badge_id"], name: "index_badges_sashes_on_badge_id"
    t.index ["sash_id"], name: "index_badges_sashes_on_sash_id"
  end

  create_table "bulletins", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "post_type", default: "general"
  end

  create_table "bundlelinks", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.integer "writer_id", null: false
    t.boolean "shared", default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["writer_id"], name: "index_bundlelinks_on_writer_id"
  end

  create_table "buy_products", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "group_purchase_id"
    t.integer "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_purchase_id"], name: "index_buy_products_on_group_purchase_id"
    t.index ["product_id"], name: "index_buy_products_on_product_id"
  end

  create_table "codebanks", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "title", null: false
    t.text "summary"
    t.text "snippet", null: false
    t.integer "writer_id"
    t.boolean "shared"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["writer_id"], name: "index_codebanks_on_writer_id"
  end

  create_table "comments", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "commentable_id"
    t.string "commentable_type"
    t.integer "writer_id"
    t.text "content", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type"
    t.index ["writer_id"], name: "index_comments_on_writer_id"
  end

  create_table "courses", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "title", null: false
    t.text "summary"
    t.integer "tutor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "published", default: false
    t.datetime "published_at"
    t.index ["tutor_id"], name: "index_courses_on_tutor_id"
  end

  create_table "delayed_jobs", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "events", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string "location"
    t.string "fb_event_id"
    t.text "description"
    t.decimal "latitude", precision: 10, scale: 6
    t.decimal "longitude", precision: 10, scale: 6
    t.datetime "updated_time"
    t.text "material"
    t.boolean "modifiable", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "event_url"
  end

  create_table "favlinks", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.string "linkurl", null: false
    t.integer "writer_id"
    t.boolean "shared", default: true
    t.integer "bundlelink_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "capture_loc"
    t.boolean "with_screen_shot", default: true
    t.string "capture_loc_manual"
    t.index ["bundlelink_id"], name: "index_favlinks_on_bundlelink_id"
    t.index ["writer_id"], name: "index_favlinks_on_writer_id"
  end

  create_table "friendly_id_slugs", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "glossaries", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "user_id"
    t.string "term", null: false
    t.integer "word_class"
    t.boolean "idiomatic"
    t.text "memo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "word_class_cd"
    t.string "slug"
    t.index ["slug"], name: "index_glossaries_on_slug", unique: true
    t.index ["user_id"], name: "index_glossaries_on_user_id"
  end

  create_table "glossary_definitions", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "glossary_id"
    t.integer "user_id"
    t.string "definition", null: false
    t.text "sentence"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "cached_votes_total", default: 0
    t.integer "cached_votes_score", default: 0
    t.integer "cached_votes_up", default: 0
    t.integer "cached_votes_down", default: 0
    t.integer "cached_weighted_score", default: 0
    t.integer "cached_weighted_total", default: 0
    t.float "cached_weighted_average", default: 0.0
    t.index ["cached_votes_down"], name: "index_glossary_definitions_on_cached_votes_down"
    t.index ["cached_votes_score"], name: "index_glossary_definitions_on_cached_votes_score"
    t.index ["cached_votes_total"], name: "index_glossary_definitions_on_cached_votes_total"
    t.index ["cached_votes_up"], name: "index_glossary_definitions_on_cached_votes_up"
    t.index ["cached_weighted_average"], name: "index_glossary_definitions_on_cached_weighted_average"
    t.index ["cached_weighted_score"], name: "index_glossary_definitions_on_cached_weighted_score"
    t.index ["cached_weighted_total"], name: "index_glossary_definitions_on_cached_weighted_total"
    t.index ["glossary_id"], name: "index_glossary_definitions_on_glossary_id"
    t.index ["user_id"], name: "index_glossary_definitions_on_user_id"
  end

  create_table "group_purchases", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "event_name", null: false
    t.text "event_info"
    t.datetime "start_date", null: false
    t.datetime "end_date"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_group_purchases_on_user_id"
  end

  create_table "impressions", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "impressionable_type"
    t.integer "impressionable_id"
    t.integer "user_id"
    t.string "controller_name"
    t.string "action_name"
    t.string "view_name"
    t.string "request_hash"
    t.string "ip_address"
    t.string "session_hash"
    t.text "message"
    t.text "referrer"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "params"
    t.index ["controller_name", "action_name", "ip_address"], name: "controlleraction_ip_index"
    t.index ["controller_name", "action_name", "request_hash"], name: "controlleraction_request_index"
    t.index ["controller_name", "action_name", "session_hash"], name: "controlleraction_session_index"
    t.index ["impressionable_type", "impressionable_id", "ip_address"], name: "poly_ip_index"
    t.index ["impressionable_type", "impressionable_id", "params"], name: "poly_params_request_index", length: { params: 100 }
    t.index ["impressionable_type", "impressionable_id", "request_hash"], name: "poly_request_index"
    t.index ["impressionable_type", "impressionable_id", "session_hash"], name: "poly_session_index"
    t.index ["impressionable_type", "message", "impressionable_id"], name: "impressionable_type_message_index", length: { message: 255 }
    t.index ["user_id"], name: "index_impressions_on_user_id"
  end

  create_table "items", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "purchase_request_id"
    t.string "shirts_color", limit: 1
    t.string "shirts_size", limit: 3
    t.integer "count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["purchase_request_id"], name: "index_items_on_purchase_request_id"
  end

  create_table "labnotes", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "title", null: false
    t.text "summary"
    t.text "codesnippet", null: false
    t.integer "writer_id"
    t.boolean "shared"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["writer_id"], name: "index_labnotes_on_writer_id"
  end

  create_table "lectures", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "course_id"
    t.string "title", null: false
    t.text "content"
    t.string "youtube_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.boolean "published", default: false
    t.datetime "published_at"
    t.index ["course_id"], name: "index_lectures_on_course_id"
    t.index ["user_id"], name: "index_lectures_on_user_id"
  end

  create_table "merit_actions", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "user_id"
    t.string "action_method"
    t.integer "action_value"
    t.boolean "had_errors", default: false
    t.string "target_model"
    t.integer "target_id"
    t.boolean "processed", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "merit_activity_logs", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "action_id"
    t.string "related_change_type"
    t.integer "related_change_id"
    t.string "description"
    t.datetime "created_at"
  end

  create_table "merit_score_points", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "score_id"
    t.integer "num_points", default: 0
    t.string "log"
    t.datetime "created_at"
  end

  create_table "merit_scores", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "sash_id"
    t.string "category", default: "default"
  end

  create_table "news_sections", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_news_sections_on_user_id"
  end

  create_table "newsletters", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "title", null: false
    t.text "greeting"
    t.datetime "published_at"
    t.integer "editor_id"
    t.string "poster"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title_color"
    t.index ["editor_id"], name: "index_newsletters_on_editor_id"
  end

  create_table "plazas", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "postitable_id"
    t.string "postitable_type"
    t.boolean "visible"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["postitable_id", "postitable_type"], name: "index_plazas_on_postitable_id_and_postitable_type"
  end

  create_table "podcasts", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "uid"
    t.string "title"
    t.string "author"
    t.text "description"
    t.text "enclosure_url"
    t.integer "enclosure_size", default: 0
    t.string "duration"
    t.date "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.integer "writer_id"
    t.boolean "published", default: false
    t.datetime "published_at"
    t.integer "hit", default: 0
    t.datetime "deleted_at"
    t.integer "bulletin_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "picture"
    t.integer "sash_id"
    t.integer "level", default: 0
    t.index ["bulletin_id"], name: "index_posts_on_bulletin_id"
    t.index ["writer_id"], name: "index_posts_on_writer_id"
  end

  create_table "products", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.integer "unit_price", default: 0
    t.integer "total_stock_count", default: 0
    t.boolean "sold_out", default: false
    t.datetime "sold_out_at"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_products_on_user_id"
  end

  create_table "purchase_requests", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "user_id"
    t.date "send_date"
    t.string "sender_name", limit: 10
    t.integer "send_total_price", default: 0
    t.boolean "confirmed", default: false
    t.datetime "confirmed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "delivery", default: false
    t.string "parcel_zip", limit: 10
    t.string "parcel_addr"
    t.string "parcel_receiver", limit: 10
    t.text "memo"
    t.integer "group_purchase_id"
    t.boolean "deleted", default: false
    t.datetime "deleted_at"
    t.integer "deleted_by_id"
    t.index ["deleted_by_id"], name: "index_purchase_requests_on_deleted_by_id"
    t.index ["group_purchase_id"], name: "index_purchase_requests_on_group_purchase_id"
    t.index ["user_id"], name: "index_purchase_requests_on_user_id"
  end

  create_table "questions", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "sash_id"
    t.integer "level", default: 0
    t.index ["user_id"], name: "index_questions_on_user_id"
  end

  create_table "rblogs", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.integer "writer_id"
    t.boolean "shared"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["writer_id"], name: "index_rblogs_on_writer_id"
  end

  create_table "recommandations", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "schedule_id"
    t.integer "applier_id"
    t.integer "recommander_id"
    t.integer "score", default: 0
    t.text "letter"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["applier_id"], name: "index_recommandations_on_applier_id"
    t.index ["recommander_id"], name: "index_recommandations_on_recommander_id"
    t.index ["schedule_id"], name: "index_recommandations_on_schedule_id"
  end

  create_table "roles", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.integer "resource_id"
    t.string "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
  end

  create_table "sashes", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schedules", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "user_id"
    t.string "name", null: false
    t.text "info"
    t.string "venue"
    t.datetime "start_date"
    t.datetime "end_date"
    t.boolean "repeating"
    t.boolean "charged", default: false
    t.integer "charge_amount", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "pre_start_date"
    t.datetime "pre_end_date"
    t.index ["user_id"], name: "index_schedules_on_user_id"
  end

  create_table "taggings", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "tag_id"
    t.integer "taggable_id"
    t.string "taggable_type"
    t.integer "tagger_id"
    t.string "tagger_type"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
  end

  create_table "tags", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "name", collation: "utf8_bin"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "useful_answers", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "user_id"
    t.integer "answer_id"
    t.index ["answer_id", "user_id"], name: "index_useful_answers_on_answer_id_and_user_id", unique: true
    t.index ["user_id", "answer_id"], name: "index_useful_answers_on_user_id_and_answer_id", unique: true
  end

  create_table "user_profiles", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "user_id"
    t.string "name", null: false
    t.string "github"
    t.text "intro", null: false
    t.string "blog"
    t.string "website"
    t.string "company"
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar"
    t.index ["user_id"], name: "index_user_profiles_on_user_id"
  end

  create_table "users", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "sash_id"
    t.integer "level", default: 0
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
  end

  create_table "votes", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "votable_id"
    t.string "votable_type"
    t.integer "voter_id"
    t.string "voter_type"
    t.boolean "vote_flag"
    t.string "vote_scope"
    t.integer "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
    t.index ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"
  end

  create_table "websites", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "site_url", null: false
    t.integer "service_state"
    t.integer "service_type"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "service_type_cd"
    t.integer "service_state_cd"
    t.text "memo"
    t.index ["user_id"], name: "index_websites_on_user_id"
  end

  create_table "weeklynews", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "uid", null: false
    t.string "subject", null: false
    t.datetime "sended_at", null: false
    t.text "url", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["sended_at"], name: "index_weeklynews_on_sended_at"
  end

  add_foreign_key "appliers", "schedules"
  add_foreign_key "appliers", "users"
  add_foreign_key "articles", "news_sections"
  add_foreign_key "articles", "newsletters"
  add_foreign_key "articles", "users", column: "reporter_id"
  add_foreign_key "buy_products", "group_purchases"
  add_foreign_key "buy_products", "products"
  add_foreign_key "courses", "users", column: "tutor_id"
  add_foreign_key "glossaries", "users"
  add_foreign_key "glossary_definitions", "glossaries"
  add_foreign_key "glossary_definitions", "users"
  add_foreign_key "group_purchases", "users"
  add_foreign_key "items", "purchase_requests"
  add_foreign_key "lectures", "courses"
  add_foreign_key "lectures", "users"
  add_foreign_key "news_sections", "users"
  add_foreign_key "newsletters", "users", column: "editor_id"
  add_foreign_key "products", "users"
  add_foreign_key "purchase_requests", "group_purchases"
  add_foreign_key "purchase_requests", "users"
  add_foreign_key "purchase_requests", "users", column: "deleted_by_id"
  add_foreign_key "recommandations", "appliers"
  add_foreign_key "recommandations", "schedules"
  add_foreign_key "recommandations", "users", column: "recommander_id"
  add_foreign_key "schedules", "users"
  add_foreign_key "user_profiles", "users"
  add_foreign_key "websites", "users"
end
