class CreateSurveyResponses < ActiveRecord::Migration
  def change
    create_table :survey_responses do |t|
      t.integer :response

      t.references :user
      t.references :survey_question
      t.timestamps null: false
    end
  end
end
