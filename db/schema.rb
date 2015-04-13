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

ActiveRecord::Schema.define(:version => 20150412220144) do

  create_table "championship_users", :force => true do |t|
    t.integer "championship_id"
    t.integer "user_id"
  end

  create_table "championships", :force => true do |t|
    t.string   "name"
    t.integer  "rule_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.date     "date_start"
  end

  add_index "championships", ["id"], :name => "index_championships_on_id"
  add_index "championships", ["rule_id"], :name => "fk_championships_rules"

  create_table "games", :force => true do |t|
    t.integer  "championship_id"
    t.integer  "team1_id"
    t.integer  "placar1"
    t.integer  "team2_id"
    t.integer  "placar2"
    t.integer  "phase_id"
    t.string   "groups"
    t.string   "stage"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "duel1"
    t.string   "duel2"
  end

  add_index "games", ["championship_id"], :name => "fk_games_championships"
  add_index "games", ["id"], :name => "index_games_on_id"
  add_index "games", ["phase_id"], :name => "fk_games_phases"
  add_index "games", ["team1_id"], :name => "fk_games_team1"
  add_index "games", ["team2_id"], :name => "fk_games_team2"

  create_table "phases", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "phases", ["id"], :name => "index_phases_on_id"

  create_table "rules", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "rules", ["id"], :name => "index_rules_on_id"

  create_table "teams", :force => true do |t|
    t.integer  "championship_id"
    t.string   "name"
    t.string   "logo"
    t.string   "abbreviation"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "teams", ["championship_id"], :name => "fk_teams_championships"
  add_index "teams", ["id"], :name => "index_teams_on_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,  :null => false
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
