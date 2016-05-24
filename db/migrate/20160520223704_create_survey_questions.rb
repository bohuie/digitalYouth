class CreateSurveyQuestions < ActiveRecord::Migration
  def change
    create_table :survey_questions do |t|
      t.integer :category
      t.string :prompt

      t.references :survey
      t.timestamps null: false
    end
  end
end
