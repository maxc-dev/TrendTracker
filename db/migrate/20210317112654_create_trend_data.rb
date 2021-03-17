class CreateTrendData < ActiveRecord::Migration[5.2]
  def change
    create_table :trend_data do |t|
      t.belongs_to :location, foreign_key: true, null: false
      t.belongs_to :trend, foreign_key: true, null: false

      t.timestamps
    end
  end
end
