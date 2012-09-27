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

ActiveRecord::Schema.define(:version => 20120927045905) do

  create_table "counties", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "fires", :force => true do |t|
    t.string   "fire_name"
    t.string   "fire_county"
    t.string   "fire_address"
    t.integer  "total_acres_burned"
    t.string   "fire_contained"
    t.string   "date_fires_started"
    t.string   "last_date_fire_updated"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

end
