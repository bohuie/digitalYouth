class CreateProjectSkills < ActiveRecord::Migration
	def change
		create_table :project_skills do |t|

			t.belongs_to :project, index: true
			t.belongs_to :skill, index: true

			t.timestamps null: false
		end
	end
end
