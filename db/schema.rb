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

ActiveRecord::Schema.define(version: 20160520224524) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "collaboration_survey_responses", force: :cascade do |t|
    t.integer  "Q1_SQid"
    t.integer  "Q1"
    t.integer  "Q2_SQid"
    t.integer  "Q2"
    t.integer  "Q3_SQid"
    t.integer  "Q3"
    t.integer  "Q4_SQid"
    t.integer  "Q4"
    t.integer  "Q5_SQid"
    t.integer  "Q5"
    t.integer  "Q6_SQid"
    t.integer  "Q6"
    t.integer  "Q7_SQid"
    t.integer  "Q7"
    t.integer  "Q8_SQid"
    t.integer  "Q8"
    t.integer  "Q9_SQid"
    t.integer  "Q9"
    t.integer  "Q10_SQid"
    t.integer  "Q10"
    t.integer  "Q11_SQid"
    t.integer  "Q11"
    t.integer  "Q12_SQid"
    t.integer  "Q12"
    t.integer  "Q13_SQid"
    t.integer  "Q13"
    t.integer  "Q14_SQid"
    t.integer  "Q14"
    t.integer  "Q15_SQid"
    t.integer  "Q15"
    t.integer  "Q16_SQid"
    t.integer  "Q16"
    t.integer  "Q17_SQid"
    t.integer  "Q17"
    t.integer  "Q18_SQid"
    t.integer  "Q18"
    t.integer  "Q19_SQid"
    t.integer  "Q19"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "general_survey_responses", force: :cascade do |t|
    t.integer  "Q1_SQid"
    t.integer  "Q1"
    t.integer  "Q2_SQid"
    t.integer  "Q2"
    t.integer  "Q3_SQid"
    t.integer  "Q3"
    t.integer  "Q4_SQid"
    t.integer  "Q4"
    t.integer  "Q5_SQid"
    t.integer  "Q5"
    t.integer  "Q6_SQid"
    t.integer  "Q6"
    t.integer  "Q7_SQid"
    t.integer  "Q7"
    t.integer  "Q8_SQid"
    t.integer  "Q8"
    t.integer  "Q9_SQid"
    t.integer  "Q9"
    t.integer  "Q10_SQid"
    t.integer  "Q10"
    t.integer  "Q11_SQid"
    t.integer  "Q11"
    t.integer  "Q12_SQid"
    t.integer  "Q12"
    t.integer  "Q13_SQid"
    t.integer  "Q13"
    t.integer  "Q14_SQid"
    t.integer  "Q14"
    t.integer  "Q15_SQid"
    t.integer  "Q15"
    t.integer  "Q16_SQid"
    t.integer  "Q16"
    t.integer  "Q17_SQid"
    t.integer  "Q17"
    t.integer  "Q18_SQid"
    t.integer  "Q18"
    t.integer  "Q19_SQid"
    t.integer  "Q19"
    t.integer  "Q20_SQid"
    t.integer  "Q20"
    t.integer  "Q21_SQid"
    t.integer  "Q21"
    t.integer  "Q22_SQid"
    t.integer  "Q22"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "job_postings", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.date     "open_date"
    t.date     "close_date"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "modern_skills_survey_responses", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "money_survey_responses", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "multimedia_survey_responses", force: :cascade do |t|
    t.integer  "Q1_SQid"
    t.integer  "Q1"
    t.integer  "Q2_SQid"
    t.integer  "Q2"
    t.integer  "Q3_SQid"
    t.integer  "Q3"
    t.integer  "Q4_SQid"
    t.integer  "Q4"
    t.integer  "Q5_SQid"
    t.integer  "Q5"
    t.integer  "Q6_SQid"
    t.integer  "Q6"
    t.integer  "Q7_SQid"
    t.integer  "Q7"
    t.integer  "Q8_SQid"
    t.integer  "Q8"
    t.integer  "Q9_SQid"
    t.integer  "Q9"
    t.integer  "Q10_SQid"
    t.integer  "Q10"
    t.integer  "Q11_SQid"
    t.integer  "Q11"
    t.integer  "Q12_SQid"
    t.integer  "Q12"
    t.integer  "Q13_SQid"
    t.integer  "Q13"
    t.integer  "Q14_SQid"
    t.integer  "Q14"
    t.integer  "Q15_SQid"
    t.integer  "Q15"
    t.integer  "Q16_SQid"
    t.integer  "Q16"
    t.integer  "Q17_SQid"
    t.integer  "Q17"
    t.integer  "Q18_SQid"
    t.integer  "Q18"
    t.integer  "Q19_SQid"
    t.integer  "Q19"
    t.integer  "Q20_SQid"
    t.integer  "Q20"
    t.integer  "Q21_SQid"
    t.integer  "Q21"
    t.integer  "Q22_SQid"
    t.integer  "Q22"
    t.integer  "Q23_SQid"
    t.integer  "Q23"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "networking_survey_responses", force: :cascade do |t|
    t.integer  "Q1_SQid"
    t.integer  "Q1"
    t.integer  "Q2_SQid"
    t.integer  "Q2"
    t.integer  "Q3_SQid"
    t.integer  "Q3"
    t.integer  "Q4_SQid"
    t.integer  "Q4"
    t.integer  "Q5_SQid"
    t.integer  "Q5"
    t.integer  "Q6_SQid"
    t.integer  "Q6"
    t.integer  "Q7_SQid"
    t.integer  "Q7"
    t.integer  "Q8_SQid"
    t.integer  "Q8"
    t.integer  "Q9_SQid"
    t.integer  "Q9"
    t.integer  "Q10_SQid"
    t.integer  "Q10"
    t.integer  "Q11_SQid"
    t.integer  "Q11"
    t.integer  "Q12_SQid"
    t.integer  "Q12"
    t.integer  "Q13_SQid"
    t.integer  "Q13"
    t.integer  "Q14_SQid"
    t.integer  "Q14"
    t.integer  "Q15_SQid"
    t.integer  "Q15"
    t.integer  "Q16_SQid"
    t.integer  "Q16"
    t.integer  "Q17_SQid"
    t.integer  "Q17"
    t.integer  "Q18_SQid"
    t.integer  "Q18"
    t.integer  "Q19_SQid"
    t.integer  "Q19"
    t.integer  "Q20_SQid"
    t.integer  "Q20"
    t.integer  "Q21_SQid"
    t.integer  "Q21"
    t.integer  "Q22_SQid"
    t.integer  "Q22"
    t.integer  "Q23_SQid"
    t.integer  "Q23"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "presentation_survey_responses", force: :cascade do |t|
    t.integer  "Q1_SQid"
    t.integer  "Q1"
    t.integer  "Q2_SQid"
    t.integer  "Q2"
    t.integer  "Q3_SQid"
    t.integer  "Q3"
    t.integer  "Q4_SQid"
    t.integer  "Q4"
    t.integer  "Q5_SQid"
    t.integer  "Q5"
    t.integer  "Q6_SQid"
    t.integer  "Q6"
    t.integer  "Q7_SQid"
    t.integer  "Q7"
    t.integer  "Q8_SQid"
    t.integer  "Q8"
    t.integer  "Q9_SQid"
    t.integer  "Q9"
    t.integer  "Q10_SQid"
    t.integer  "Q10"
    t.integer  "Q11_SQid"
    t.integer  "Q11"
    t.integer  "Q12_SQid"
    t.integer  "Q12"
    t.integer  "Q13_SQid"
    t.integer  "Q13"
    t.integer  "Q14_SQid"
    t.integer  "Q14"
    t.integer  "Q15_SQid"
    t.integer  "Q15"
    t.integer  "Q16_SQid"
    t.integer  "Q16"
    t.integer  "Q17_SQid"
    t.integer  "Q17"
    t.integer  "Q18_SQid"
    t.integer  "Q18"
    t.integer  "Q19_SQid"
    t.integer  "Q19"
    t.integer  "Q20_SQid"
    t.integer  "Q20"
    t.integer  "Q21_SQid"
    t.integer  "Q21"
    t.integer  "Q22_SQid"
    t.integer  "Q22"
    t.integer  "Q23_SQid"
    t.integer  "Q23"
    t.integer  "Q24_SQid"
    t.integer  "Q24"
    t.integer  "Q25_SQid"
    t.integer  "Q25"
    t.integer  "Q26_SQid"
    t.integer  "Q26"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "programming_survey_responses", force: :cascade do |t|
    t.integer  "Q1_SQid"
    t.integer  "Q1"
    t.integer  "Q2_SQid"
    t.integer  "Q2"
    t.integer  "Q3_SQid"
    t.integer  "Q3"
    t.integer  "Q4_SQid"
    t.integer  "Q4"
    t.integer  "Q5_SQid"
    t.integer  "Q5"
    t.integer  "Q6_SQid"
    t.integer  "Q6"
    t.integer  "Q7_SQid"
    t.integer  "Q7"
    t.integer  "Q8_SQid"
    t.integer  "Q8"
    t.integer  "Q9_SQid"
    t.integer  "Q9"
    t.integer  "Q10_SQid"
    t.integer  "Q10"
    t.integer  "Q11_SQid"
    t.integer  "Q11"
    t.integer  "Q12_SQid"
    t.integer  "Q12"
    t.integer  "Q13_SQid"
    t.integer  "Q13"
    t.integer  "Q14_SQid"
    t.integer  "Q14"
    t.integer  "Q15_SQid"
    t.integer  "Q15"
    t.integer  "Q16_SQid"
    t.integer  "Q16"
    t.integer  "Q17_SQid"
    t.integer  "Q17"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "project_skills", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "skill_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "project_skills", ["project_id"], name: "index_project_skills_on_project_id", using: :btree
  add_index "project_skills", ["skill_id"], name: "index_project_skills_on_skill_id", using: :btree

  create_table "project_survey_responses", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "user_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "reference_emails", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "reference_url"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "reference_redirections", force: :cascade do |t|
    t.string   "reference_url"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "reference_redirections", ["reference_url"], name: "index_reference_redirections_on_reference_url", unique: true, using: :btree

  create_table "references", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "company"
    t.string   "position"
    t.string   "phone_number"
    t.text     "reference_body"
    t.boolean  "confirmed",      default: false
    t.integer  "user_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", unique: true, using: :btree

  create_table "skills", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "social_media_survey_responses", force: :cascade do |t|
    t.integer  "Q1_SQid"
    t.integer  "Q1"
    t.integer  "Q2_SQid"
    t.integer  "Q2"
    t.integer  "Q3_SQid"
    t.integer  "Q3"
    t.integer  "Q4_SQid"
    t.integer  "Q4"
    t.integer  "Q5_SQid"
    t.integer  "Q5"
    t.integer  "Q6_SQid"
    t.integer  "Q6"
    t.integer  "Q7_SQid"
    t.integer  "Q7"
    t.integer  "Q8_SQid"
    t.integer  "Q8"
    t.integer  "Q9_SQid"
    t.integer  "Q9"
    t.integer  "Q10_SQid"
    t.integer  "Q10"
    t.integer  "Q11_SQid"
    t.integer  "Q11"
    t.integer  "Q12_SQid"
    t.integer  "Q12"
    t.integer  "Q13_SQid"
    t.integer  "Q13"
    t.integer  "Q14_SQid"
    t.integer  "Q14"
    t.integer  "Q15_SQid"
    t.integer  "Q15"
    t.integer  "Q16_SQid"
    t.integer  "Q16"
    t.integer  "Q17_SQid"
    t.integer  "Q17"
    t.integer  "Q18_SQid"
    t.integer  "Q18"
    t.integer  "Q19_SQid"
    t.integer  "Q19"
    t.integer  "Q20_SQid"
    t.integer  "Q20"
    t.integer  "Q21_SQid"
    t.integer  "Q21"
    t.integer  "Q22_SQid"
    t.integer  "Q22"
    t.integer  "Q23_SQid"
    t.integer  "Q23"
    t.integer  "Q24_SQid"
    t.integer  "Q24"
    t.integer  "Q25_SQid"
    t.integer  "Q25"
    t.integer  "Q26_SQid"
    t.integer  "Q26"
    t.integer  "Q27_SQid"
    t.integer  "Q27"
    t.integer  "Q28_SQid"
    t.integer  "Q28"
    t.integer  "Q29_SQid"
    t.integer  "Q29"
    t.integer  "Q30_SQid"
    t.integer  "Q30"
    t.integer  "Q31_SQid"
    t.integer  "Q31"
    t.integer  "Q32_SQid"
    t.integer  "Q32"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spreadsheet_survey_responses", force: :cascade do |t|
    t.integer  "Q1_SQid"
    t.integer  "Q1"
    t.integer  "Q2_SQid"
    t.integer  "Q2"
    t.integer  "Q3_SQid"
    t.integer  "Q3"
    t.integer  "Q4_SQid"
    t.integer  "Q4"
    t.integer  "Q5_SQid"
    t.integer  "Q5"
    t.integer  "Q6_SQid"
    t.integer  "Q6"
    t.integer  "Q7_SQid"
    t.integer  "Q7"
    t.integer  "Q8_SQid"
    t.integer  "Q8"
    t.integer  "Q9_SQid"
    t.integer  "Q9"
    t.integer  "Q10_SQid"
    t.integer  "Q10"
    t.integer  "Q11_SQid"
    t.integer  "Q11"
    t.integer  "Q12_SQid"
    t.integer  "Q12"
    t.integer  "Q13_SQid"
    t.integer  "Q13"
    t.integer  "Q14_SQid"
    t.integer  "Q14"
    t.integer  "Q15_SQid"
    t.integer  "Q15"
    t.integer  "Q16_SQid"
    t.integer  "Q16"
    t.integer  "Q17_SQid"
    t.integer  "Q17"
    t.integer  "Q18_SQid"
    t.integer  "Q18"
    t.integer  "Q19_SQid"
    t.integer  "Q19"
    t.integer  "Q20_SQid"
    t.integer  "Q20"
    t.integer  "Q21_SQid"
    t.integer  "Q21"
    t.integer  "Q22_SQid"
    t.integer  "Q22"
    t.integer  "Q23_SQid"
    t.integer  "Q23"
    t.integer  "Q24_SQid"
    t.integer  "Q24"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "survey_analyses", force: :cascade do |t|
    t.integer  "category_0"
    t.integer  "category_1"
    t.integer  "category_2"
    t.integer  "category_3"
    t.integer  "survey_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "survey_questions", force: :cascade do |t|
    t.integer  "category"
    t.integer  "survey_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "survey_responses", force: :cascade do |t|
    t.integer  "response"
    t.integer  "user_id"
    t.integer  "survey_question_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "surveys", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_skills", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "skill_id"
    t.integer  "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_skills", ["skill_id"], name: "index_user_skills_on_skill_id", using: :btree
  add_index "user_skills", ["user_id"], name: "index_user_skills_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "github"
    t.string   "linkedin"
    t.string   "twitter"
    t.string   "company_name"
    t.string   "company_address"
    t.string   "company_city"
    t.string   "company_province"
    t.string   "company_postal_code"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

  create_table "word_processing_survey_responses", force: :cascade do |t|
    t.integer  "Q1_SQid"
    t.integer  "Q1"
    t.integer  "Q2_SQid"
    t.integer  "Q2"
    t.integer  "Q3_SQid"
    t.integer  "Q3"
    t.integer  "Q4_SQid"
    t.integer  "Q4"
    t.integer  "Q5_SQid"
    t.integer  "Q5"
    t.integer  "Q6_SQid"
    t.integer  "Q6"
    t.integer  "Q7_SQid"
    t.integer  "Q7"
    t.integer  "Q8_SQid"
    t.integer  "Q8"
    t.integer  "Q9_SQid"
    t.integer  "Q9"
    t.integer  "Q10_SQid"
    t.integer  "Q10"
    t.integer  "Q11_SQid"
    t.integer  "Q11"
    t.integer  "Q12_SQid"
    t.integer  "Q12"
    t.integer  "Q13_SQid"
    t.integer  "Q13"
    t.integer  "Q14_SQid"
    t.integer  "Q14"
    t.integer  "Q15_SQid"
    t.integer  "Q15"
    t.integer  "Q16_SQid"
    t.integer  "Q16"
    t.integer  "Q17_SQid"
    t.integer  "Q17"
    t.integer  "Q18_SQid"
    t.integer  "Q18"
    t.integer  "Q19_SQid"
    t.integer  "Q19"
    t.integer  "Q20_SQid"
    t.integer  "Q20"
    t.integer  "Q21_SQid"
    t.integer  "Q21"
    t.integer  "Q22_SQid"
    t.integer  "Q22"
    t.integer  "Q23_SQid"
    t.integer  "Q23"
    t.integer  "Q24_SQid"
    t.integer  "Q24"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
