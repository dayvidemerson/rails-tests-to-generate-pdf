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

ActiveRecord::Schema.define(version: 20190320165633) do

  create_table "benchmark_tests", force: :cascade do |t|
    t.string   "description"
    t.string   "from"
    t.string   "url"
    t.decimal  "user_cpu_time"
    t.decimal  "system_cpu_time"
    t.decimal  "total_cpu_time"
    t.decimal  "real_cpu_time"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.decimal  "memory_usage"
    t.integer  "quantity"
  end

  create_table "collaborators", force: :cascade do |t|
    t.string   "name"
    t.decimal  "salary"
    t.date     "admission_date"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

end
