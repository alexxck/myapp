class Post < ApplicationRecord
  validates :name, :title, presence: true, length: { minimum: 3 }
  belongs_to :author
  has_many :comments
  mount_uploader :image, ImageUploader

end

