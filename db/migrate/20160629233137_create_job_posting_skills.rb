class CreateJobPostingSkills < ActiveRecord::Migration
  def change
    create_table :job_posting_skills do |t|

    	t.integer :importance
    	t.belongs_to :job_posting, index: true
		t.belongs_to :skill, index: true
		t.belongs_to :question, index: true
		
      	t.timestamps null: false
    end
  end
end
