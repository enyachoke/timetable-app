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

ActiveRecord::Schema.define(:version => 20130702074434) do

  create_table "buildings", :force => true do |t|
    t.string   "title"
    t.string   "address"
    t.integer  "organization_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "buildings", ["organization_id"], :name => "index_buildings_on_organization_id"

  create_table "classrooms", :force => true do |t|
    t.string   "number"
    t.integer  "building_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "classrooms", ["building_id"], :name => "index_classrooms_on_building_id"

  create_table "lecturers", :force => true do |t|
    t.string   "name"
    t.string   "patronymic"
    t.string   "surname"
    t.integer  "organization_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "lecturers", ["organization_id"], :name => "index_lecturers_on_organization_id"

  create_table "memberships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "organization_id"
    t.string   "role"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "memberships", ["organization_id"], :name => "index_memberships_on_organization_id"
  add_index "memberships", ["user_id"], :name => "index_memberships_on_user_id"

  create_table "organizations", :force => true do |t|
    t.text     "title"
    t.string   "email"
    t.string   "phone"
    t.string   "site"
    t.string   "subdomain"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
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
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
