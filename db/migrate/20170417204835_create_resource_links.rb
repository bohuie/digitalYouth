class CreateResourceLinks < ActiveRecord::Migration
  def change
    create_table :resource_links do |t|
      t.boolean :home_page_job_provider
      t.boolean :home_page_job_seeker
      t.boolean :bucket_job_provider
      t.boolean :bucket_job_seeker
      t.boolean :announcement
      t.string 	:link
      t.string	:message

      t.timestamps null: false
    end
  end
end
