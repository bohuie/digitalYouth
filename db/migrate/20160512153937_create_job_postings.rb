  class CreateJobPostings < ActiveRecord::Migration
  def change
    create_table :job_postings do |t|

    	t.string :title
      t.string :location
      t.string :pay_range
      t.string :link
      t.string :posted_by
      t.string :category
    	t.text :description
    	t.date :open_date
    	t.date :close_date
      t.attachment :company_logo

    	t.references :user
      t.timestamps null: false
    end
  end
end
