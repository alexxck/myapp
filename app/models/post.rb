# frozen_string_literal: true

class Post < ApplicationRecord
  validates :name, :title, presence: true, length: { minimum: 3 }
  validates :author_id, presence: true
  belongs_to :author
  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :comments
  has_one_attached :image, dependent: :destroy
  mount_uploader :image, ImageUploader
  is_impressionable
end
