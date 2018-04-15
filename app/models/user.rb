class User < ApplicationRecord
  has_secure_password

  validates :name, uniqueness: true, length: { minimum: 4 }
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates_numericality_of :cut_percentage, greater_than: 0, less_than: 1
end
