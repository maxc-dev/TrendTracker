class CreateDiscoveries < ActiveRecord::Migration[5.2]
  def change
    create_table :discoveries do |t|

      t.timestamps
    end
  end
end
