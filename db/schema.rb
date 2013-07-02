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

ActiveRecord::Schema.define(:version => 20130701235851) do

  create_table "championships", :force => true do |t|
    t.string   "name"
    t.integer  "rule_id"
    t.integer  "classification"
    t.integer  "groups"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "games", :force => true do |t|
    t.integer  "championship_id"
    t.integer  "team1_id"
    t.integer  "placar1"
    t.integer  "team2_id"
    t.integer  "placar2"
    t.integer  "phase_id"
    t.string   "groups"
    t.string   "stage"
    t.string   "duel"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "phases", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "rules", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.string   "logo"
    t.string   "abbreviation"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

end
