class TrendDatum < ApplicationRecord
  validates :location_id, presence: true, null: false
  validates :trend_id, presence: true, null: false

  belongs_to :trend
  belongs_to :location

  scope :from_id, ->(loc_id) { where(['id = ?', loc_id]) }
end
