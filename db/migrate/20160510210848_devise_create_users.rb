class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string  :email,              null: false, default: ""
      t.string  :encrypted_password, null: false, default: ""
      t.string  :first_name
      t.string  :last_name
      t.attachment :image

      #social media
      t.string  :github
      t.string  :linkedin
      t.string  :twitter
      t.string  :facebook

      #company info
      t.string  :company_name

      #encrypted info
      t.string  :encrypted_street_address
      t.string  :encrypted_street_address_iv
      t.string  :encrypted_unit_number
      t.string  :encrypted_unit_number_iv
      t.string  :encrypted_postal_code
      t.string  :encrypted_postal_code_iv

      #location info
      t.string  :city
      t.string  :province

      #Bio info
      t.string  :bio

      #Survey tracking - survey_id-1 maps to each spot in the array
      t.boolean :answered_surveys, array: true, default: [false, false, false, false, false, false, false, false, false, false, false, false]

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      # t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet     :current_sign_in_ip
      t.inet     :last_sign_in_ip

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      t.string   :unlock_token # Only if unlock strategy is :email or :both
      t.datetime :locked_at


      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :confirmation_token,   unique: true
    add_index :users, :unlock_token,         unique: true
  end
end
