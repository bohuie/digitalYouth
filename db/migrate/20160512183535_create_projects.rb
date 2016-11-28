class CreateProjects < ActiveRecord::Migration
	def change
		create_table :projects do |t|

			t.string :title
			t.text :description
			t.attachment :image
			t.date :project_date

			t.references :user

			t.timestamps null: false
		end
	end
end
