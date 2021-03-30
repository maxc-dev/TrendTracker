class RemoveTrackingFromUserPrivacies < ActiveRecord::Migration[5.2]
  def change
    remove_column :user_privacies, :tracking, :boolean
    remove_index :user_privacies, :location_id
    remove_column :user_privacies, :location_id, :string
  end
end
