class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
	  t.string  :email,              null: false, default: ""
      t.string  :name
      t.string  :message

      t.timestamps null: false
    end
  end
end
