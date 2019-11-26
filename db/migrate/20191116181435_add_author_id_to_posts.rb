# frozen_string_literal: true

class AddAuthorIdToPosts < ActiveRecord::Migration[6.0]
  def change
    add_reference :posts, :author
  end
end
