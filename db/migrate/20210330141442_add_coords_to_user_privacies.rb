class AddCoordsToUserPrivacies < ActiveRecord::Migration[5.2]
  def change
    add_column :user_privacies, :latitude, :decimal
    add_column :user_privacies, :longitude, :decimal
  end
end
