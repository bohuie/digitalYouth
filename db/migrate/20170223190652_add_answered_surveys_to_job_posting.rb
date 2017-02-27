class AddAnsweredSurveysToJobPosting < ActiveRecord::Migration
  def change
    add_column :job_postings, :answered_surveys, :boolean, array: true, default: [false, false, false, false, false, false, false, false, false, false, false, false]
  end
end
