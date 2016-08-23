class CreateReferences < ActiveRecord::Migration
  def change
    create_table :references do |t|

      t.string  :first_name
      t.string  :last_name
      t.string	:email
      t.string	:company
      t.string	:position
      t.string :phone_number
      t.text	:reference_body
      t.boolean :confirmed, default: false

      t.references :referee
      t.references :user
      t.timestamps null: false
    end
  end
end
