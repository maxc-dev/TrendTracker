class TrendDatum < ApplicationRecord
  validates :location_id, presence: true, null: false, uniqueness: true
  validates :trend_id, presence: true, null: false

  belongs_to :trend
  belongs_to :location

  scope :from_id, ->(loc_id) { where(['id = ?', loc_id]) }
end
