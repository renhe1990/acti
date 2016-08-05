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

ActiveRecord::Schema.define(version: 20141224065550) do

  create_table "areas", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "article_categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "articles", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status",              default: 0
    t.integer  "article_category_id"
    t.string   "type"
    t.string   "video"
  end

  add_index "articles", ["article_category_id"], name: "index_articles_on_article_category_id", using: :btree
  add_index "articles", ["status"], name: "index_articles_on_status", using: :btree

  create_table "attachments", force: true do |t|
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.string   "asset"
    t.string   "content_type"
    t.integer  "file_size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attachments", ["attachable_id", "attachable_type"], name: "index_attachments_on_attachable_id_and_attachable_type", using: :btree

  create_table "banners", force: true do |t|
    t.string   "image"
    t.integer  "position",   default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_id"
  end

  create_table "campaigns", force: true do |t|
    t.integer  "project_id"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "location"
    t.date     "starts_at"
    t.date     "ends_at"
    t.integer  "position"
  end

  create_table "cells", force: true do |t|
    t.string   "icon"
    t.string   "title"
    t.text     "content",    limit: 2147483647
    t.string   "url"
    t.boolean  "editable",                      default: true
    t.boolean  "active",                        default: false
    t.integer  "position",                      default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_id"
  end

  create_table "cities", force: true do |t|
    t.string   "name"
    t.string   "province_id"
    t.integer  "level"
    t.string   "zip_code"
    t.string   "pinyin"
    t.string   "pinyin_abbr"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "course_lecturers", force: true do |t|
    t.integer  "course_id"
    t.integer  "lecturer_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courses", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.date     "starts_at"
    t.date     "ends_at"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "wizard_step"
    t.time     "starts_at_time"
    t.time     "ends_at_time"
    t.integer  "serial_id"
    t.string   "location"
    t.integer  "campaign_id"
    t.integer  "schedule_id"
    t.string   "genre"
    t.string   "hour"
    t.boolean  "public"
    t.integer  "survey_count",     default: 0
    t.integer  "position"
    t.integer  "public_course_id"
  end

  add_index "courses", ["campaign_id"], name: "index_courses_on_campaign_id", using: :btree
  add_index "courses", ["schedule_id"], name: "index_courses_on_schedule_id", using: :btree
  add_index "courses", ["user_id"], name: "index_courses_on_user_id", using: :btree

  create_table "draw_items", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "draw_id"
    t.datetime "time"
    t.integer  "position",    default: 1
  end

  create_table "draw_results", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "draw_id"
    t.integer  "draw_item_id"
  end

  add_index "draw_results", ["user_id"], name: "index_draw_results_on_user_id", using: :btree

  create_table "draws", force: true do |t|
    t.integer  "course_id"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
    t.integer  "position"
  end

  create_table "events", force: true do |t|
    t.integer  "section_id"
    t.string   "name"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "schedule_id"
    t.string   "type"
    t.text     "description"
    t.integer  "course_id"
    t.integer  "user_id"
    t.integer  "position"
  end

  add_index "events", ["course_id"], name: "index_events_on_course_id", using: :btree
  add_index "events", ["schedule_id"], name: "index_events_on_schedule_id", using: :btree
  add_index "events", ["user_id"], name: "index_events_on_user_id", using: :btree

  create_table "features", force: true do |t|
    t.string   "title"
    t.string   "video"
    t.string   "video_screenshot"
    t.string   "cover"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "columns",          default: 1
    t.integer  "position",         default: 0
    t.integer  "project_id"
  end

  add_index "features", ["position"], name: "index_features_on_position", using: :btree

  create_table "grades", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "images", force: true do |t|
    t.string   "file"
    t.string   "alt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "impressions", force: true do |t|
    t.string   "impressionable_type"
    t.integer  "impressionable_id"
    t.integer  "user_id"
    t.string   "controller_name"
    t.string   "action_name"
    t.string   "view_name"
    t.string   "request_hash"
    t.string   "ip_address"
    t.string   "session_hash"
    t.text     "message"
    t.text     "referrer"
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

  create_table "menus", force: true do |t|
    t.string   "name"
    t.string   "url"
    t.boolean  "private",     default: false
    t.string   "ancestry"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position",    default: 0
    t.integer  "category",    default: 0
    t.string   "title"
    t.text     "description"
    t.string   "image"
  end

  create_table "opinionnaire_reviewees", force: true do |t|
    t.integer  "opinionnaire_id"
    t.integer  "reviewee_id"
    t.integer  "position",        default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", force: true do |t|
    t.string   "title"
    t.string   "slug"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "participations", force: true do |t|
    t.integer  "participateable_id"
    t.string   "participateable_type"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position",             default: 0
  end

  add_index "participations", ["participateable_id", "participateable_type"], name: "index_participations_on_participateable", using: :btree
  add_index "participations", ["user_id"], name: "index_participations_on_user_id", using: :btree

  create_table "photos", force: true do |t|
    t.integer  "photoable_id"
    t.string   "photoable_type"
    t.string   "image"
    t.string   "content_type"
    t.string   "file_size"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "column",         default: 1
  end

  add_index "photos", ["photoable_id", "photoable_type"], name: "index_photos_on_photoable_id_and_photoable_type", using: :btree

  create_table "project_lecturers", force: true do |t|
    t.integer  "project_id"
    t.integer  "lecturer_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "project_lecturers", ["lecturer_id"], name: "index_project_lecturers_on_lecturer_id", using: :btree
  add_index "project_lecturers", ["project_id"], name: "index_project_lecturers_on_project_id", using: :btree

  create_table "projects", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",            default: true
    t.string   "template"
    t.integer  "position"
    t.string   "wechat_background"
    t.string   "ancestry"
  end

  create_table "provinces", force: true do |t|
    t.string   "name"
    t.string   "pinyin"
    t.string   "pinyin_abbr"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reviews", force: true do |t|
    t.integer  "context_id"
    t.string   "context_type"
    t.integer  "reviewable_id"
    t.string   "reviewable_type"
    t.integer  "reviewer_id"
    t.string   "reviewer_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "attempt_id"
  end

  add_index "reviews", ["context_id", "context_type"], name: "index_reviews_on_context_id_and_context_type", using: :btree
  add_index "reviews", ["reviewable_id", "reviewable_type"], name: "index_reviews_on_reviewable_id_and_reviewable_type", using: :btree
  add_index "reviews", ["reviewer_id", "reviewer_type"], name: "index_reviews_on_reviewer_id_and_reviewer_type", using: :btree

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schedules", force: true do |t|
    t.date     "date"
    t.string   "title"
    t.string   "hint"
    t.integer  "campaign_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  create_table "serials", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "survey_answers", force: true do |t|
    t.integer  "attempt_id"
    t.integer  "question_id"
    t.integer  "option_id"
    t.boolean  "correct"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "text"
    t.integer  "rating"
    t.integer  "review_id"
  end

  create_table "survey_attempts", force: true do |t|
    t.integer "participant_id"
    t.string  "participant_type"
    t.integer "survey_id"
    t.boolean "winner"
    t.integer "score"
    t.string  "surveyable_type"
    t.integer "surveyable_id"
  end

  add_index "survey_attempts", ["surveyable_type", "surveyable_id"], name: "index_survey_attempts_on_surveyable_type_and_surveyable_id", using: :btree

  create_table "survey_options", force: true do |t|
    t.integer  "question_id"
    t.integer  "weight",      default: 0
    t.string   "text"
    t.boolean  "correct"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  create_table "survey_questions", force: true do |t|
    t.integer  "survey_id"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
    t.integer  "position"
    t.integer  "maximum"
    t.string   "order",       default: "asc"
    t.boolean  "mandatory",   default: true
    t.text     "description"
    t.integer  "weight",      default: 1
  end

  add_index "survey_questions", ["type"], name: "index_survey_questions_on_type", using: :btree

  create_table "survey_surveys", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "attempts_number", default: 0
    t.boolean  "finished",        default: false
    t.boolean  "active",          default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
    t.integer  "user_id"
    t.integer  "course_id"
    t.text     "comment"
    t.boolean  "display_score",   default: false
    t.integer  "lesson_id"
    t.integer  "lecturer_weight", default: 1
    t.integer  "student_weight",  default: 1
    t.integer  "position"
  end

  add_index "survey_surveys", ["lesson_id"], name: "index_survey_surveys_on_lesson_id", using: :btree
  add_index "survey_surveys", ["type"], name: "index_survey_surveys_on_type", using: :btree
  add_index "survey_surveys", ["user_id"], name: "index_survey_surveys_on_user_id", using: :btree

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree

  create_table "tags", force: true do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "card_number"
    t.string   "name"
    t.string   "password_digest"
    t.string   "mobile"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "province_id"
    t.string   "provider"
    t.string   "uid"
    t.integer  "role_id"
    t.integer  "area_id"
    t.integer  "grade_id"
    t.integer  "gender"
    t.datetime "deleted_at"
    t.integer  "status",          default: 0
    t.string   "wechat_nickname"
    t.integer  "city_id"
    t.integer  "diet"
  end

  add_index "users", ["provider", "uid"], name: "index_users_on_provider_and_uid", using: :btree
  add_index "users", ["province_id"], name: "index_users_on_province_id", using: :btree

  create_table "vote_item_options", force: true do |t|
    t.integer  "vote_item_id"
    t.text     "text"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "vote_item_options", ["user_id"], name: "index_vote_item_options_on_user_id", using: :btree
  add_index "vote_item_options", ["vote_item_id"], name: "index_vote_item_options_on_vote_item_id", using: :btree

  create_table "vote_items", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "vote_id"
    t.integer  "position",    default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "vote_items", ["vote_id"], name: "index_vote_items_on_vote_id", using: :btree

  create_table "vote_result_items", force: true do |t|
    t.integer  "vote_result_id"
    t.integer  "vote_item_option_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "vote_result_items", ["vote_item_option_id"], name: "index_vote_result_items_on_vote_item_option_id", using: :btree
  add_index "vote_result_items", ["vote_result_id"], name: "index_vote_result_items_on_vote_result_id", using: :btree

  create_table "vote_results", force: true do |t|
    t.integer  "vote_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "vote_results", ["user_id"], name: "index_vote_results_on_user_id", using: :btree
  add_index "vote_results", ["vote_id"], name: "index_vote_results_on_vote_id", using: :btree

  create_table "votes", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  add_index "votes", ["course_id"], name: "index_votes_on_course_id", using: :btree

end
