class CreateContactUserEmails < ActiveRecord::Migration
  def change
    create_table :contact_user_emails do |t|

      t.timestamps null: false
    end
  end
end
