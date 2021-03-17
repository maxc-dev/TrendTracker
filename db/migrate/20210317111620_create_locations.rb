class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.integer :woeid, null: false
      t.string :country, null: false
      t.string :name, null: false
      t.string :countryCode
      t.decimal :x, null: false, default: -100
      t.decimal :y, null: false, default: -100

      t.timestamps
    end
  end
end
