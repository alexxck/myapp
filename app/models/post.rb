class Post < ApplicationRecord
  validates :name, :title, presence: true, length: { minimum: 3 }
  has_one :author
  belongs_to :author

end
