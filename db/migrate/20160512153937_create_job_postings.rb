  class CreateJobPostings < ActiveRecord::Migration
  def change
    create_table :job_postings do |t|

    	t.string :title
      t.string :company_name #ONLY USED FOR AUTOPOPULATION
      t.string :location
      t.string :pay_range
      t.string :link
      t.string :posted_by
    	t.text :description
    	t.date :open_date
    	t.date :close_date
      t.attachment :company_logo
      t.integer :views, null: false, default: 0

    	t.references :user
      t.references :job_category
      t.timestamps null: false
    end
  end
end
