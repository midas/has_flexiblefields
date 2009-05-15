ActiveRecord::Migration.verbose = false

ActiveRecord::Schema.define do

  create_table "posts" do |t|
    t.string   "title"
    t.text     "body"
    t.boolean  "published"
    t.datetime "created_at"
    t.datetime "updated_at"
  end
  
end