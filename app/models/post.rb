class Post < ApplicationRecord
  validates :name, :title, presence: true, length: { minimum: 3 }
  belongs_to :author
  mount_uploader :image, ImageUploader
end

