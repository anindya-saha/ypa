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

ActiveRecord::Schema.define(:version => 20141120052156) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.text     "desc"
    t.string   "created_by"
    t.string   "updated_by"
    t.boolean  "deleted"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "events", :primary_key => "event_id", :force => true do |t|
    t.string   "name",                                :null => false
    t.text     "desc"
    t.date     "from_date",                           :null => false
    t.date     "to_date",                             :null => false
    t.time     "from_time"
    t.time     "to_time"
    t.string   "venue"
    t.integer  "category_id"
    t.integer  "min_before_start"
    t.integer  "max_before_end"
    t.string   "created_by"
    t.string   "updated_by"
    t.boolean  "deleted",          :default => false, :null => false
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
  end

  create_table "interests", :force => true do |t|
    t.text     "description"
    t.string   "created_by"
    t.string   "updated_by"
    t.boolean  "deleted"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "user_events", :force => true do |t|
    t.integer  "user_id",                       :null => false
    t.integer  "event_id",                      :null => false
    t.boolean  "rsvp",       :default => false, :null => false
    t.boolean  "signin",     :default => false, :null => false
    t.string   "created_by"
    t.string   "updated_by"
    t.boolean  "deleted",    :default => false, :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "users", :primary_key => "user_id", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.date     "dob"
    t.string   "phone"
    t.string   "organization"
    t.string   "interests"
    t.boolean  "volunteer",              :default => false
    t.boolean  "donate",                 :default => false
    t.boolean  "admin",                  :default => false, :null => false
    t.boolean  "deleted",                :default => false
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,     :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
