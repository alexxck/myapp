# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :author
  validates :commenter_name, :comment, presence: true, length: { minimum: 3 }
end
