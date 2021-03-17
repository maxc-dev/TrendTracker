class TrendDatum < ApplicationRecord
  validates :location_id, presence: true, null: false
  validates :trend_id, presence: true, null: false

  belongs_to :trend
  belongs_to :location
end
