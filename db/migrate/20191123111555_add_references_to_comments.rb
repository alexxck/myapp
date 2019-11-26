# frozen_string_literal: true

class AddReferencesToComments < ActiveRecord::Migration[6.0]
  def change
    add_reference :comments, :author
  end
end
