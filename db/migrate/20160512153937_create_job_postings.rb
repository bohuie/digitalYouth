  class CreateJobPostings < ActiveRecord::Migration
  def change
    create_table :job_postings do |t|

    	t.string :title
      t.string :company_name # ONLY USED FOR AUTOPOPULATION
      t.string :location
      t.string :pay_range
      t.string :link
      t.string :posted_by
      # job_type:
      # 0 Full time, 1 Part Time, 2 Contract, 3 Casual, 4 Summer Positions,
      # 5 Graduate Year Recruitment Program, 6 Field Placement/Work Practicum
      # 7 Internship, 8 Volunteer
      t.integer :job_type 
    	t.text :description
    	t.date :open_date
    	t.date :close_date
      t.integer :views, null: false, default: 0

    	t.references :user
      t.references :job_category
      t.timestamps null: false
    end
  end
end