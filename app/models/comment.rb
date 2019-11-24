# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :author
  validates :name, :body, presence: true, length: { minimum: 3 }
end
