# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100306075756) do

  create_table "comments", :force => true do |t|
    t.text     "text"
    t.integer  "submitter_id"
    t.integer  "target_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rating_types", :force => true do |t|
    t.text     "male_name"
    t.text     "female_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ratings", :force => true do |t|
    t.integer  "score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.integer  "number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "registration_enabled",            :default => false
    t.boolean  "commenting_enabled",              :default => false
    t.boolean  "commenting_results_view_enabled", :default => false
    t.boolean  "active",                          :default => false
    t.boolean  "matching_enabled",                :default => false
    t.boolean  "matching_results_view_enabled",   :default => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "password_hash"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "view_type",                 :default => "normal_view"
    t.boolean  "admin",                     :default => false
    t.datetime "last_visit_to_result_list"
    t.boolean  "enabled",                   :default => false
    t.boolean  "shown",                     :default => true
    t.string   "avatar_link",               :default => ""
  end

end
