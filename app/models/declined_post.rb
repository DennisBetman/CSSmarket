class DeclinedPost < ApplicationRecord
  validates :post_id, presence: true
  validates :description, presence: true, length: { minimum: 8 }
end
