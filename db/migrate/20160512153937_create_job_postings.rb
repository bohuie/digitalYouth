  class CreateJobPostings < ActiveRecord::Migration
  def change
    create_table :job_postings do |t|

    	t.string :title
    	t.text :description
    	t.date :open_date
    	t.date :close_date

    	t.references :user
      t.timestamps null: false
    end
  end
end
