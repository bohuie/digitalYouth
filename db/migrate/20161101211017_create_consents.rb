class CreateConsents < ActiveRecord::Migration
  def change
    create_table :consents do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :answer
      t.string :name
      t.date :date_signed
      t.integer :consent_type

      t.timestamps null: false
    end
  end
end
