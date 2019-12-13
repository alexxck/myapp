# frozen_string_literal: true

class Comment < ApplicationRecord
  acts_as_votable
  belongs_to :post
  belongs_to :author
  validates :body, presence: true, length: { minimum: 3 }
  has_ancestry
end
