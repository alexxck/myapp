# frozen_string_literal: true

class AddImage2Post < ActiveRecord::Migration[6.0]
  def change
    change_table :posts do |t|
      t.string :image
    end
  end
end
