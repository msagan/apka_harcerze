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

ActiveRecord::Schema.define(version: 20151009171217) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "badge_requirements", force: true do |t|
    t.integer  "badge_id"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "badge_requirements", ["badge_id"], name: "index_badge_requirements_on_badge_id", using: :btree

  create_table "badge_requirements_plan_points", force: true do |t|
    t.integer "badge_requirement_id"
    t.integer "plan_point_id"
  end

  add_index "badge_requirements_plan_points", ["badge_requirement_id"], name: "index_badge_requirements_plan_points_on_badge_requirement_id", using: :btree
  add_index "badge_requirements_plan_points", ["plan_point_id"], name: "index_badge_requirements_plan_points_on_plan_point_id", using: :btree

  create_table "badge_requirements_users", force: true do |t|
    t.integer "badge_requirement_id"
    t.integer "user_id"
  end

  add_index "badge_requirements_users", ["badge_requirement_id"], name: "index_badge_requirements_users_on_badge_requirement_id", using: :btree
  add_index "badge_requirements_users", ["user_id"], name: "index_badge_requirements_users_on_user_id", using: :btree

  create_table "badge_trials", force: true do |t|
    t.integer  "user_id"
    t.integer  "badge_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "badge_trials", ["badge_id"], name: "index_badge_trials_on_badge_id", using: :btree
  add_index "badge_trials", ["user_id"], name: "index_badge_trials_on_user_id", using: :btree

  create_table "badges", force: true do |t|
    t.integer  "color"
    t.string   "name"
    t.text     "description"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "emblem_file_name"
    t.string   "emblem_content_type"
    t.integer  "emblem_file_size"
    t.datetime "emblem_updated_at"
  end

  create_table "badges_custom_tasks", force: true do |t|
    t.integer "badge_id"
    t.integer "custom_task_id"
  end

  add_index "badges_custom_tasks", ["custom_task_id"], name: "index_badges_custom_tasks_on_custom_task_id", using: :btree

  create_table "badges_cycles", force: true do |t|
    t.integer "badge_id"
    t.integer "cycle_id"
  end

  add_index "badges_cycles", ["badge_id"], name: "index_badges_cycles_on_badge_id", using: :btree
  add_index "badges_cycles", ["cycle_id"], name: "index_badges_cycles_on_cycle_id", using: :btree

  create_table "badges_to_trials", force: true do |t|
    t.integer "badge_id"
    t.integer "trial_id"
  end

  add_index "badges_to_trials", ["badge_id"], name: "index_badges_to_trials_on_badge_id", using: :btree
  add_index "badges_to_trials", ["trial_id"], name: "index_badges_to_trials_on_trial_id", using: :btree

  create_table "badges_year_plans", force: true do |t|
    t.integer "badge_id"
    t.integer "year_plan_id"
  end

  add_index "badges_year_plans", ["badge_id"], name: "index_badges_year_plans_on_badge_id", using: :btree
  add_index "badges_year_plans", ["year_plan_id"], name: "index_badges_year_plans_on_year_plan_id", using: :btree

  create_table "custom_tasks", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "trial_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "badge_id"
  end

  add_index "custom_tasks", ["badge_id"], name: "index_custom_tasks_on_badge_id", using: :btree
  add_index "custom_tasks", ["trial_id"], name: "index_custom_tasks_on_trial_id", using: :btree
  add_index "custom_tasks", ["user_id"], name: "index_custom_tasks_on_user_id", using: :btree

  create_table "custom_tasks_rank_requirements", force: true do |t|
    t.integer "rank_requirement_id"
    t.integer "custom_task_id"
  end

  add_index "custom_tasks_rank_requirements", ["custom_task_id"], name: "index_custom_tasks_rank_requirements_on_custom_task_id", using: :btree
  add_index "custom_tasks_rank_requirements", ["rank_requirement_id"], name: "index_custom_tasks_rank_requirements_on_rank_requirement_id", using: :btree

  create_table "cycles", force: true do |t|
    t.string   "name"
    t.integer  "team_id"
    t.datetime "start_date"
    t.datetime "stop_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "year_plan_id"
  end

  add_index "cycles", ["team_id"], name: "index_cycles_on_team_id", using: :btree
  add_index "cycles", ["year_plan_id"], name: "index_cycles_on_year_plan_id", using: :btree

  create_table "meetings", force: true do |t|
    t.string   "name"
    t.datetime "start_date"
    t.datetime "stop_date"
    t.integer  "cycle_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "summed_up"
  end

  add_index "meetings", ["cycle_id"], name: "index_meetings_on_cycle_id", using: :btree

  create_table "meetings_users", force: true do |t|
    t.integer "meeting_id"
    t.integer "user_id"
  end

  add_index "meetings_users", ["meeting_id"], name: "index_meetings_users_on_meeting_id", using: :btree
  add_index "meetings_users", ["user_id"], name: "index_meetings_users_on_user_id", using: :btree

  create_table "plan_points", force: true do |t|
    t.string   "task_name"
    t.integer  "task_time"
    t.text     "task_info"
    t.text     "materials_needed"
    t.string   "person_responsible"
    t.integer  "set_id"
    t.string   "set_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "badge_requirement_id"
  end

  add_index "plan_points", ["badge_requirement_id"], name: "index_plan_points_on_badge_requirement_id", using: :btree
  add_index "plan_points", ["set_id", "set_type"], name: "index_plan_points_on_set_id_and_set_type", using: :btree

  create_table "plans", force: true do |t|
    t.integer  "meeting_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "plans", ["meeting_id"], name: "index_plans_on_meeting_id", using: :btree

  create_table "rank_requirements", force: true do |t|
    t.integer  "color"
    t.text     "description"
    t.integer  "trial_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "rank_id"
  end

  add_index "rank_requirements", ["rank_id"], name: "index_rank_requirements_on_rank_id", using: :btree
  add_index "rank_requirements", ["trial_id"], name: "index_rank_requirements_on_trial_id", using: :btree

  create_table "rank_requirements_to_badges", force: true do |t|
    t.integer "badge_id"
    t.integer "rank_requirement_id"
  end

  add_index "rank_requirements_to_badges", ["badge_id"], name: "index_rank_requirements_to_badges_on_badge_id", using: :btree
  add_index "rank_requirements_to_badges", ["rank_requirement_id"], name: "index_rank_requirements_to_badges_on_rank_requirement_id", using: :btree

  create_table "ranks", force: true do |t|
    t.integer  "level"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "trial_id"
  end

  add_index "ranks", ["trial_id"], name: "index_ranks_on_trial_id", using: :btree

  create_table "team_groups", force: true do |t|
    t.integer  "team_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "team_groups", ["team_id"], name: "index_team_groups_on_team_id", using: :btree

  create_table "teams", force: true do |t|
    t.string   "name"
    t.text     "history"
    t.text     "situation_description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "base"
    t.string   "adjutant_1"
    t.string   "adjutant_2"
    t.string   "banner"
    t.string   "chapter"
    t.date     "date_of_creation"
    t.text     "ceremonial"
  end

  create_table "trials", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "completed",  default: false
    t.integer  "badge_id"
  end

  add_index "trials", ["badge_id"], name: "index_trials_on_badge_id", using: :btree
  add_index "trials", ["user_id"], name: "index_trials_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: ""
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "User"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "stars",                  default: 0
    t.text     "description"
    t.integer  "pesel"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "school"
    t.string   "school_class"
    t.boolean  "parental_agreement"
    t.text     "medical_info"
    t.integer  "team_id"
    t.boolean  "admin",                  default: false
    t.boolean  "scouts_mark"
    t.date     "date_of_admission"
    t.date     "date_of_leave"
    t.string   "parent_1"
    t.string   "parent_2"
    t.boolean  "archived"
    t.integer  "parent_1_phone"
    t.integer  "parent_2_phone"
    t.datetime "birth_date"
    t.string   "parent_1_email"
    t.string   "parent_2_email"
    t.integer  "team_group_id"
    t.string   "leave_reason"
  end

  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["team_group_id"], name: "index_users_on_team_group_id", using: :btree
  add_index "users", ["team_id"], name: "index_users_on_team_id", using: :btree

  create_table "year_plans", force: true do |t|
    t.integer  "team_id"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "year_plans", ["team_id"], name: "index_year_plans_on_team_id", using: :btree

end
