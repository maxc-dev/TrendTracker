class UserPrivacy < ApplicationRecord
  # validates that the user is set and is valid
  validates :user_id, presence: true, null: false

  # associations
  belongs_to :user

  scope :user_agreement, ->(user_id) { where(['user_id = ?', user_id]) }
end
