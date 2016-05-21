class CreateSurveyAnalyses < ActiveRecord::Migration
  def change
    create_table :survey_analyses do |t|
      t.integer :category_0, :category_1, :category_2, :category_3
      
      t.references :survey
      t.references :user
      t.timestamps null: false
    end
  end
end
