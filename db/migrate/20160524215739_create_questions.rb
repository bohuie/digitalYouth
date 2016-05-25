class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :classification

      t.references :survey
      t.timestamps null: false
    end
  end
end
