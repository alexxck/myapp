class Post < ApplicationRecord
  validates :name, :title, presence: true,
            length: { minimum: 5 }
end
