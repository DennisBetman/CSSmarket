class Widthdrawl < ApplicationRecord
  validates :amount, presence: true, numericality: true
  validates :user_id, presence: true
end
