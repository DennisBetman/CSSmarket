class Post < ActiveRecord::Base
  has_many :cart_posts
  has_many :carts, :through => :cart_posts

  mount_uploader :image, PostImageUploader
  mount_uploader :file, PostFileUploader

  attribute :user_name, :string

  validates :title, presence: true, length: { minimum: 8 }, uniqueness: true
  validates :price, presence: true, numericality: true
  validates :user_id, presence: true
  validates_inclusion_of :categories, :in => ["buttons", "menus", "forms"]
end
