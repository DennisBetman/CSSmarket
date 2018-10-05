class User < ApplicationRecord
  has_secure_password

  enum level: { regular: 0, seller: 1, admin: 100 }
  enum status: { active: 0, deleted: 1 }

  validates :name, uniqueness: true, length: { minimum: 4 }
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates_numericality_of :cut_percentage, greater_than: 0, less_than: 1
end
