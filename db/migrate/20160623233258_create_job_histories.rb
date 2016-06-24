class CreateJobHistories < ActiveRecord::Migration
  def change
    create_table :job_histories do |t|
	
	t.string :employer
	t.date :start_date
	t.date :end_date
	t.string :position
	t.text :description
	t.text :skills

	t.references :user

      t.timestamps null: false
    end
  end
end
