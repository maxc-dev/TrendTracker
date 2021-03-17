class Location < ApplicationRecord
  validates :woeid, presence: true, null: false
  validates :country, presence: true, null: false
  validates :name, presence: true, null: false

  has_many :trend_data, dependent: :destroy

  scope :from_id, ->(loc_id) { where(['id = ?', loc_id]) }
end
