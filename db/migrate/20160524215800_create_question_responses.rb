class CreateQuestionResponses < ActiveRecord::Migration
  def change
    create_table :question_responses do |t|

    	t.belongs_to :question, index: true
		t.belongs_to :response, index: true

      t.timestamps null: false
    end
  end
end
