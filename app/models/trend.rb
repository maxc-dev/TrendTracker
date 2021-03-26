class Trend < ApplicationRecord
  validates :name, presence: true, null: false, uniqueness: true

  has_many :trend_data, dependent: :destroy

  scope :from_id, ->(trend_id) { where(['id = ?', trend_id]) }
  scope :trend_by_name, ->(trend_name) { where(['name = ?', trend_name]) }
end
