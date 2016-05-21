class CreateModernSkillsSurveyResponses < ActiveRecord::Migration
  def change
    create_table :modern_skills_survey_responses do |t|

      t.timestamps null: false
    end
  end
end
