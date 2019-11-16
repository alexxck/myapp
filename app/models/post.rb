class Post < ApplicationRecord
  validates :name, :title, presence: true, length: { minimum: 3 }
  belongs_to :author
  accepts_nested_attributes_for :author
end
