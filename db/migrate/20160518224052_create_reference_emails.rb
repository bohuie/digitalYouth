class CreateReferenceEmails < ActiveRecord::Migration
  def change
    create_table :reference_emails do |t|
    	t.string :first_name
    	t.string :last_name
    	t.string :email
    	t.string :reference_url
      	t.string :message

      t.timestamps null: false
    end
  end
end
