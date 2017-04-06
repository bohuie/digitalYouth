class AddJobPostingToResponses < ActiveRecord::Migration
  def change
    add_reference :responses, :job_posting, index: true, foreign_key: true
  end
end
