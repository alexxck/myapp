# frozen_string_literal: true

class Post < ApplicationRecord
  validates :name, :title, presence: true, length: { minimum: 3 }
  belongs_to :author
  has_many :comments, dependent: :destroy
  mount_uploader :image, ImageUploader
  is_impressionable
end
