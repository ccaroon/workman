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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120615154028) do

  create_table "countdowns", :force => true do |t|
    t.string   "title",                          :null => false
    t.datetime "target_date",                    :null => false
    t.string   "units",       :default => "day", :null => false
    t.boolean  "on_homepage", :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "entries", :force => true do |t|
    t.date     "task_date",                        :null => false
    t.datetime "entry_date",                       :null => false
    t.string   "ticket_num"
    t.string   "subject",     :default => "",      :null => false
    t.text     "description",                      :null => false
    t.string   "category",    :default => "Other", :null => false
    t.integer  "goal_id"
  end

  add_index "entries", ["id"], :name => "id", :unique => true

  create_table "goals", :force => true do |t|
    t.integer  "priority",                            :null => false
    t.string   "name",                                :null => false
    t.text     "description"
    t.datetime "created_on",                          :null => false
    t.datetime "updated_on",                          :null => false
    t.boolean  "completed",        :default => false, :null => false
    t.datetime "completed_on"
    t.integer  "percent_complete", :default => 0,     :null => false
  end

  create_table "lists", :force => true do |t|
    t.string "name", :null => false
  end

  create_table "notes", :force => true do |t|
    t.string   "title",                           :null => false
    t.datetime "created_on",                      :null => false
    t.datetime "updated_on",                      :null => false
    t.text     "body",                            :null => false
    t.boolean  "is_favorite",  :default => false, :null => false
    t.boolean  "is_encrypted", :default => false, :null => false
    t.datetime "deleted_on"
  end

  create_table "obstacles", :force => true do |t|
    t.string   "title",       :null => false
    t.text     "description"
    t.boolean  "is_overcome", :null => false
    t.integer  "goal_id",     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "todos", :force => true do |t|
    t.integer  "priority",                                        :null => false
    t.string   "title",                                           :null => false
    t.datetime "created_on",                                      :null => false
    t.boolean  "completed",                    :default => false, :null => false
    t.datetime "completed_on"
    t.date     "due_on"
    t.integer  "list_id"
    t.string   "description",  :limit => 1024
  end

  create_table "users", :force => true do |t|
    t.string  "name",                                  :null => false
    t.string  "user_name",                             :null => false
    t.string  "password",                              :null => false
    t.string  "jira_host"
    t.string  "jira_username"
    t.string  "jira_password"
    t.integer "jira_filter_id"
    t.string  "email_type",     :default => "smtp",    :null => false
    t.string  "smtp_host"
    t.string  "smtp_user"
    t.string  "smtp_pass"
    t.string  "smtp_auth"
    t.string  "style_main",     :default => "default", :null => false
    t.string  "style_calendar", :default => "system",  :null => false
    t.string  "email",          :default => "",        :null => false
  end

  create_table "work_days", :force => true do |t|
    t.date    "work_date",                                      :null => false
    t.time    "in",                                             :null => false
    t.time    "out",                                            :null => false
    t.string  "note"
    t.boolean "is_vacation", :default => false,                 :null => false
    t.boolean "is_holiday",  :default => false,                 :null => false
    t.boolean "is_sick_day", :default => false,                 :null => false
    t.time    "lunch",       :default => '2000-01-01 00:00:00'
  end

end
