class CreateJobPostingApplications < ActiveRecord::Migration
  def change
    create_table :job_posting_applications do |t|

    	t.text :message
    	t.references :applicant
      	t.references :company
      	t.references :job_posting
      	t.integer :status, null: false, default: 0 #0 = Undetermined, -1 = rejected, 1 = considering, 2 = accepted
      	t.timestamps null: false
    end
  end
end
