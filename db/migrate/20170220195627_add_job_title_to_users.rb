class AddJobTitleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :job_title, :string
    add_column :users, :current_company, :string
    add_column :users, :show_job, :boolean
  end
end
