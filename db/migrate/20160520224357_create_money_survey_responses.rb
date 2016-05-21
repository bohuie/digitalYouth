class CreateMoneySurveyResponses < ActiveRecord::Migration
  def change
    create_table :money_survey_responses do |t|

      t.timestamps null: false
    end
  end
end
