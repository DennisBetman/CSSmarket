class SellerRequest < ApplicationRecord
  validates :content, presence: true
  validates :portfolio_url, presence: true
end
