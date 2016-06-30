class CreateSkills < ActiveRecord::Migration
	def change
		create_table :skills do |t|

			t.string :name
			t.belongs_to :question

			t.timestamps null: false
		end
	end
end
