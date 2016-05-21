class CreateProjectSurveyResponses < ActiveRecord::Migration
  def change
    create_table :project_survey_responses do |t|

      t.timestamps null: false
    end
  end
end
