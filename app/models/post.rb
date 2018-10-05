class Post < ActiveRecord::Base
  mount_uploader :image, PostImageUploader
  mount_uploader :file, PostFileUploader

  attribute :user_name, :string

  validates :title, presence: true, length: { minimum: 8 }
  validates :price, presence: true, numericality: true
  validates :user_id, presence: true
  validates_inclusion_of :categories, :in => ["buttons", "menus", "forms"]
end
