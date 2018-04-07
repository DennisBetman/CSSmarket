class User < ApplicationRecord
  has_secure_password

  validates :name, uniqueness: true
  validates :email, uniqueness: true
  validates_numericality_of :cut_percentage, greater_than: 0, less_than: 1
end
