class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.integer :scores, array: true		#each index is related to the question_ids
      t.integer :question_ids, array: true	#each index is related to the scores

      t.references :user
      t.references :survey
      t.timestamps null: false
    end
  end
end
