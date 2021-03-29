class CreateUserPrivacies < ActiveRecord::Migration[5.2]
  def change
    create_table :user_privacies do |t|
      t.belongs_to :user, foreign_key: true, null: false
      t.belongs_to :location, foreign_key: true

      t.boolean :tracking, null: false, default: false
      t.date :authorization

      t.timestamps
    end
  end
end
