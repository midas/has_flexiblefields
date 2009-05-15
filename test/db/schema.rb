ActiveRecord::Migration.verbose = false

ActiveRecord::Schema.define do

  create_table "flexifield_def_entries", :force => true do |t|
    t.integer  "flexifield_def_id", :null => false
    t.string   "flexifield_name",   :null => false
    t.string   "flexifield_alias",  :null => false
    t.integer  "ordering"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "flexifield_def_entries", ["flexifield_def_id", "flexifield_name"], :name => "idx_ffonceperspecial", :unique => true
  add_index "flexifield_def_entries", ["ordering"], :name => "idx_ordering"

  create_table "flexifield_defs", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "flexifields", :force => true do |t|
    t.integer  "flexifield_def_id"
    t.integer  "flexifield_set_id"
    t.string   "flexifield_set_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ffs_01"
    t.string   "ffs_02"
    t.string   "ffs_03"
    t.string   "ffs_04"
    t.string   "ffs_05"
    t.string   "ffs_06"
    t.string   "ffs_07"
    t.string   "ffs_08"
    t.string   "ffs_09"
    t.string   "ffs_10"
    t.string   "ffs_11"
    t.string   "ffs_12"
    t.string   "ffs_13"
    t.string   "ffs_14"
    t.string   "ffs_15"
    t.string   "ffs_16"
  end

  add_index "flexifields", ["flexifield_def_id"], :name => "index_flexifields_on_flexifield_def_id"
  add_index "flexifields", ["flexifield_set_id"], :name => "index_flexifields_on_flexifield_set_id"
  add_index "flexifields", ["flexifield_set_type"], :name => "index_flexifields_on_flexifield_set_type"

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.boolean  "published"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end