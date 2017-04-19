class CreateResourceLinks < ActiveRecord::Migration
  def change
    create_table :resource_links do |t|
      t.boolean :home_page
      t.boolean :job_provider
      t.boolean :job_seeker
      t.boolean :announcement
      t.string 	:link
      t.string	:message

      t.timestamps null: false
    end
  end
end
