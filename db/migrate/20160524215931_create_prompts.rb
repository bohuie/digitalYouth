class CreatePrompts < ActiveRecord::Migration
  def change
    create_table :prompts do |t|
      t.string :prompt

      t.references :question
      t.timestamps null: false
    end
  end
end
