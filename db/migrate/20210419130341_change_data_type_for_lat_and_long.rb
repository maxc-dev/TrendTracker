class ChangeDataTypeForLatAndLong < ActiveRecord::Migration[5.2]
  def change
    change_column :user_privacies, :latitude, :string
    change_column :user_privacies, :longitude, :string
  end
end
