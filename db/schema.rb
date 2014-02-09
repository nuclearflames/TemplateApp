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

ActiveRecord::Schema.define(:version => 20140208125330) do

  create_table "admins", :force => true do |t|
    t.string   "email"
    t.string   "encrypted_password"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "forums", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.text     "description"
    t.string   "title"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "friends", :force => true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.string   "friend_type"
    t.boolean  "confirmed",   :default => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "locations", :force => true do |t|
    t.integer  "user_id"
    t.string   "country"
    t.string   "city"
    t.string   "town"
    t.string   "street"
    t.integer  "houseno"
    t.string   "postcode"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.float    "lat"
    t.float    "lng"
  end

  create_table "messages", :force => true do |t|
    t.integer  "user_id"
    t.integer  "recipient_id"
    t.string   "title"
    t.string   "content"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.boolean  "deleted",                 :default => false
    t.boolean  "read",                    :default => false
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
  end

  create_table "news", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "photos", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "description"
    t.string   "type"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "posts", :force => true do |t|
    t.integer  "topic_id"
    t.integer  "user_id"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "topics", :force => true do |t|
    t.integer  "forum_id"
    t.integer  "user_id"
    t.string   "title"
    t.text     "description"
    t.string   "category"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "forename"
    t.string   "surname"
    t.text     "aboutme"
    t.string   "alias"
    t.date     "birthday"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
